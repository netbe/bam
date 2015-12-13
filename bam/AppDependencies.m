//
//  AppDependencies.m
//  bam
//
//  Created by François Benaiteau on 28/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import "AppDependencies.h"

#import "EntryDataStore.h"
#import "EntryNotifier.h"

#import "AddEntryInteractor.h"
#import "AddEntryPresenter.h"
#import "AddEntryWireframe.h"

#import "ListEntryWireframe.h"

#import "ShowEntryInteractor.h"
#import "ShowEntryPresenter.h"
#import "ShowEntryWireframe.h"

@interface AppDependencies ()

@property(nonatomic, strong) AddEntryWireframe* addEntryWireframe;
@property(nonatomic, strong) ShowEntryWireframe* showEntryWireframe;
@end

@implementation AppDependencies

- (id)init
{
    self = [super init];
    if (self){
        [self configureDependencies];
    }
    return self;
}

- (void)configureDependencies
{
    EntryDataStore* dataStore = [[EntryDataStore alloc] init];
    EntryNotifier* notifier = [[EntryNotifier alloc] init];
    
    // List Module
    ListEntryWireframe* listWireframe = [[ListEntryWireframe alloc] init];
    [listWireframe setDataManager:dataStore];
    
    // Add Module
    AddEntryWireframe* addWireframe = [AddEntryWireframe new];
    AddEntryPresenter* addPresenter = [[AddEntryPresenter alloc] init];
    AddEntryInteractor* addInteractor = [[AddEntryInteractor alloc] initWithDataManager:dataStore];
    
    addPresenter.interactor = addInteractor;
    addWireframe.presenter = addPresenter;
    addWireframe.interactor = addInteractor;
    addPresenter.notifier = notifier;
    
    addPresenter.listWireframe = listWireframe;
    
    
    self.addEntryWireframe = addWireframe;

    // Show Module
    ShowEntryWireframe* showWireframe = [ShowEntryWireframe new];
    ShowEntryInteractor* showInteractor = [[ShowEntryInteractor alloc] initWithDataManager:dataStore notifier:notifier];
    ShowEntryPresenter* showPresenter = [ShowEntryPresenter new];
    showWireframe.interactor = showInteractor;
    showWireframe.presenter = showPresenter;
    
    self.showEntryWireframe = showWireframe;
}

- (void)installRootViewControllerIntoWindow:(UIWindow *)window
{
    [self.addEntryWireframe presentAddInterfaceFromWindow:window];
}

- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    [self.showEntryWireframe handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
}

- (void)showNotification:(UILocalNotification*)notification inWindow:(UIWindow *)window
{
    [self.showEntryWireframe showNotification:notification inWindow:window];
}

@end
