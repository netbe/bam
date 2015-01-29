//
//  ShowEntryWireframe.m
//  bam
//
//  Created by François Benaiteau on 28/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import "ShowEntryWireframe.h"

#import "ShowEntryInteractor.h"
#import "EntryViewController.h"

@implementation ShowEntryWireframe

- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    [self.interactor handleActionWithIdentifier:identifier forLocalNotification:notification];
    if (completionHandler) {
        completionHandler();
    }
}


- (void)showNotification:(UILocalNotification*)notification inWindow:(UIWindow *)window
{
    window.rootViewController = [EntryViewController new];
    [window makeKeyAndVisible];
}

@end
