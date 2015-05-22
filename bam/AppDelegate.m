//
//  AppDelegate.m
//  bam
//
//  Created by François Benaiteau on 11/04/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "AppDelegate.h"

#import "RootWireframe.h"
#import "EntryNotifier.h"   

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    if (launchOptions && launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        
    }
    
    
    if (application.applicationState == UIApplicationStateBackground) {
        // no UI required here 
        NSLog(@"background wake up");
        return YES;
    }
    
   
    self.rootWireframe = [[RootWireframe alloc] init];
    [self.rootWireframe setup];
    
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        return;// ignore notifications now, could increment a badge in future
    }
    
    // notification received when application is visible
    // for now just ignore!
    //    [NSNotificationCenter defaultCenter] postNotificationName:<#(NSString *)#> object:<#(id)#>§
    //    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
    //    NSDictionary *userInfo = notification.userInfo;
    //    NSURL *siteURL = [NSURL URLWithString:[userInfo objectForKey:@"SiteURLKey"]];
    //    [[UIApplication sharedApplication] openURL:siteURL];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EntryNotifierNotificationAgreement
                                                        object:self
                                                      userInfo:@{EntryNotifierNotificationAgreementDeniedKey: @(notificationSettings.types == UIUserNotificationTypeNone)}];
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier 
forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    // find entry from notification user info
    // remove notification
    [[UIApplication sharedApplication] cancelLocalNotification:notification];
//    if ([notification. isEqualToString:EntryNotifierNotificationCategoryDefinition]) {
        // increment period of notification
//        self.rootWireframe.notifier 
//    }
    
    
}
@end
