//
//  AppDependencies.h
//  bam
//
//  Created by François Benaiteau on 28/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDependencies : NSObject
- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler;
- (void)installRootViewControllerIntoWindow:(UIWindow *)window;
- (void)showNotification:(UILocalNotification*)notification inWindow:(UIWindow *)window;
@end
