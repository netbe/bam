//
//  AppDelegate.m
//  bam
//
//  Created by François Benaiteau on 11/04/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "AppDelegate.h"

#import "AppDependencies.h"
#import "EntryNotifier.h"

@implementation AppDelegate

- (void)processLocalNotification:(UILocalNotification*)notification
{
    [self presentWindow];
    
}

- (void)presentWindow
{
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    [self.appDependencies installRootViewControllerIntoWindow:self.window];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    self.appDependencies = [AppDependencies new];
    
    if (launchOptions && launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        [self processLocalNotification:launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]];
        return YES;
    }
    if (application.applicationState == UIApplicationStateBackground) {
        // no UI required here 
        NSLog(@"background wake up");
        return YES;
    }
    [self presentWindow];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        return;// ignore notifications now, could increment a badge in future
    }
   
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
    [self.appDependencies handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
}
@end
