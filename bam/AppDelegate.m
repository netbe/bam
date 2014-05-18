//
//  AppDelegate.m
//  bam
//
//  Created by François Benaiteau on 11/04/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "AppDelegate.h"

#import "EntryViewController.h"
#import "ServiceManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];    
    EntryViewController* entryViewController = EntryViewController.new;
    entryViewController.serviceManager = ServiceManager.new;
    [entryViewController.serviceManager setupCoreData];
    
    self.window.rootViewController = entryViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];

    NSDictionary *userInfo = notification.userInfo;
//    NSURL *siteURL = [NSURL URLWithString:[userInfo objectForKey:@"SiteURLKey"]];
//    [[UIApplication sharedApplication] openURL:siteURL];
}

@end
