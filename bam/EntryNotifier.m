//
//  EntryNotifier.m
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "EntryNotifier.h"

NSString *const EntryNotifierNotificationAgreement = @"com.fbenaiteau.bam.agreement";
NSString *const EntryNotifierNotificationAgreementDeniedKey = @"com.fbenaiteau.bam.agreement.denied";
NSString *const EntryNotifierNotificationCategoryDefinition = @"com.fbenaiteau.bam.notification.definition";


@interface EntryNotifier ()
@property(nonatomic, strong)NSOperationQueue* queue;
@end
@implementation EntryNotifier

- (void)scheduleNotificationWithText:(NSString*)text 
                            category:(NSString*)category
                   intervalInSeconds:(NSTimeInterval)seconds
                      repeatInterval:(NSCalendarUnit)repeatInterval 
                            userInfo:(NSDictionary*)userInfo
{
    self.queue.suspended = ![self notificationsAuthorizedForCategoryNamed:category];
    
    UILocalNotification* notification = [[UILocalNotification alloc] init];
    notification.alertBody = text;
    notification.category = category;
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:seconds];
    notification.repeatInterval = repeatInterval;
    notification.userInfo = userInfo;
    [self.queue addOperationWithBlock:^{
        NSLog(@"Schedule %@", notification.alertBody);
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }];
}

- (BOOL)shouldAskNotificationPermissions
{
    id object = [[NSUserDefaults standardUserDefaults] objectForKey:EntryNotifierNotificationAgreement];
    if (!object) {
        return YES;
    }else{
        return NO;
    }
}

- (void)authorizeNotifications:(BOOL)authorized
{
    [[NSUserDefaults standardUserDefaults] setBool:authorized forKey:EntryNotifierNotificationAgreement];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (authorized) {
        [self showAuthorizationDialog];
    }
}

- (void)showAuthorizationDialog
{
#ifdef __IPHONE_8_0
    UIUserNotificationCategory* definitionCategory = [self registerActions];
    NSMutableSet* categories = [NSMutableSet set];
    [categories addObject:definitionCategory];
    UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
#endif
}

#pragma mark - Private

- (BOOL)notificationsAuthorizedForCategoryNamed:(NSString*)categoryName
{
    UIUserNotificationSettings* userSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    for (UIUserNotificationCategory* category in userSettings.categories) {
        if ([category.identifier isEqual:categoryName]) {
            return YES;
        }
    }
    return NO;
}

- (void)receivedNotificationAgreement:(NSNotification*)notification
{
    BOOL notificationsDeactivated = [notification.userInfo[EntryNotifierNotificationAgreementDeniedKey] boolValue];
    // process queue
    self.queue.suspended = notificationsDeactivated;
    if (notificationsDeactivated) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

- (UIMutableUserNotificationCategory*)registerActions 
{
    UIMutableUserNotificationAction* showValueAction = [[UIMutableUserNotificationAction alloc] init];
    showValueAction.identifier = @"com.fbenaiteau.bam.notification.definition.action-seen";
    showValueAction.title = @"Seen";
    showValueAction.activationMode = UIUserNotificationActivationModeBackground;
    showValueAction.destructive = false;
    showValueAction.authenticationRequired = false;
    
    UIMutableUserNotificationCategory* category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = EntryNotifierNotificationCategoryDefinition;
    [category setActions:@[showValueAction] forContext:UIUserNotificationActionContextDefault];
    return category;
}
    
#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        self.defaultTime = 5;
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.suspended = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(receivedNotificationAgreement:) 
                                                     name:EntryNotifierNotificationAgreement
                                                   object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UIApplicationDidFinishLaunchingNotification
                                                  object:nil];
}

@end
