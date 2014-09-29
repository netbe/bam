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

#ifdef COCOAPODS_POD_AVAILABLE_TestFlightSDK
#import "TestFlight.h"
#endif

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef COCOAPODS_POD_AVAILABLE_TestFlightSDK
    // start of your application:didFinishLaunchingWithOptions
    [TestFlight takeOff:@"b483db3f-2cc5-470a-ac9b-f2f437f97112"];
#endif
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
