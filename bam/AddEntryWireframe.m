//
//  EntryWireframe.m
//  bam
//
//  Created by François Benaiteau on 01/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "AddEntryWireframe.h"

#import "EntriesCollectionViewController.h"
#import "EntryViewController.h"

@implementation AddEntryWireframe

- (void)presentAddInterfaceFromWindow:(UIWindow *)window
{
    window.rootViewController = [self createAddInterface];
    [window makeKeyAndVisible];
}

- (void)presentListInterfaceFromViewController:(UIViewController*)viewController
{
    EntriesCollectionViewController* collectionViewController = [[EntriesCollectionViewController alloc] init];
    
    
}

- (void)presentAddInterfaceFromViewController:(UIViewController*)viewController
{
    NSAssert(false, @"not implemented");
}


- (UIViewController*)createAddInterface
{
    EntryViewController* entryViewController = [EntryViewController new];
    entryViewController.eventHandler = self.presenter;
    self.presenter.view = entryViewController;
    return entryViewController;
}

@end
