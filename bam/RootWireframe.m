//
//  RootWireframe.m
//  bam
//
//  Created by François Benaiteau on 01/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "RootWireframe.h"

#import "EntryViewController.h"
#import "AddEntryInteractor.h"
#import "AddEntryPresenter.h"

#import "ListEntryWireframe.h"
#import "EntryDataStore.h"
#import "EntryNotifier.h"

@implementation RootWireframe

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self;
}

- (void)setup
{
    EntryDataStore* dataStore = [[EntryDataStore alloc] init];
    EntryNotifier* notifier = [[EntryNotifier alloc] init];
    EntryViewController* entryViewController = [[EntryViewController alloc] init];
    
    self.interactor = [[AddEntryInteractor alloc] initWithDataManager:dataStore];
    self.presenter = [[AddEntryPresenter alloc] init];
    self.presenter.interactor = self.interactor;
    self.presenter.view = entryViewController;
    self.presenter.listWireframe = [[ListEntryWireframe alloc] init];
    [self.presenter.listWireframe setDataManager:dataStore];
    
    self.presenter.notifier = notifier;
    
    entryViewController.eventHandler = self.presenter;
    self.window.rootViewController = entryViewController;
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:entryViewController];

    
    [self.window makeKeyAndVisible];
}
@end
