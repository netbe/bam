//
//  EntryNotifier.m
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "EntryNotifier.h"

NSString *const EntryNotifierNotificationAgreement = @"com.fbenaiteau.bam.agreement";
@interface EntryNotifier ()
@property(nonatomic, strong)NSOperationQueue* queue;
@end
@implementation EntryNotifier

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

- (void)scheduleNotificationWithText:(NSString*)text intervalInSeconds:(NSTimeInterval)seconds repeatInterval:(NSCalendarUnit)repeatInterval
{
    UILocalNotification* notification = [[UILocalNotification alloc] init];
    notification.alertBody = text;
    notification.alertAction = @"Check Value";
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:seconds];
    notification.repeatInterval = repeatInterval;    
    [self.queue addOperationWithBlock:^{
        NSLog(@"Schedule %@", notification.alertBody);
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }];
}

- (void)showAuthorizationDialog
{
#ifdef __IPHONE_8_0
    UIUserNotificationCategory* category = [self registerActions];
    NSMutableSet* categories = [NSMutableSet set];
    [categories addObject:category];
    UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
#endif

}
#pragma mark - Private

- (void)receivedNotificationAgreement:(NSNotification*)notification
{
    // process queue
    self.queue.suspended = NO;
}

- (void)applicationDidFinishLaunching:(NSNotification*)notification
{
}

- (UIMutableUserNotificationCategory*)registerActions 
{
    UIMutableUserNotificationAction* showValueAction = [[UIMutableUserNotificationAction alloc] init];
    showValueAction.identifier = @"com.fbenaiteau.bam.show.value";
    showValueAction.title = @"Show value";
    showValueAction.activationMode = UIUserNotificationActivationModeForeground;
    showValueAction.destructive = false;
    showValueAction.authenticationRequired = false;
    
//    UIMutableUserNotificationAction* acceptLeadAction = [[UIMutableUserNotificationAction alloc] init];
//    acceptLeadAction.identifier = @"com.fbenaiteau.bam.";
//    acceptLeadAction.title = @"Show value";
//    acceptLeadAction.activationMode = UIUserNotificationActivationModeForeground;
//    acceptLeadAction.destructive = false;
//    acceptLeadAction.authenticationRequired = false;
    
    UIMutableUserNotificationCategory* category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = @"com.fbenaiteau.bam.notification";
    [category setActions:@[showValueAction] forContext: UIUserNotificationActionContextDefault];
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
        //        didReceiveLocalNotification
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification
        //                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(applicationDidFinishLaunching:) 
                                                     name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];
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
