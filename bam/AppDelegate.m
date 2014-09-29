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
    self.rootWireframe = [[RootWireframe alloc] init];
    [self.rootWireframe setup];
    
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // notification received when application is visible
    // for now just ignore!
//    [NSNotificationCenter defaultCenter] postNotificationName:<#(NSString *)#> object:<#(id)#>
    //    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];

//    NSDictionary *userInfo = notification.userInfo;
//    NSURL *siteURL = [NSURL URLWithString:[userInfo objectForKey:@"SiteURLKey"]];
//    [[UIApplication sharedApplication] openURL:siteURL];
}

@end
