//
//  ShowEntryWireframe.h
//  bam
//
//  Created by François Benaiteau on 28/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShowEntryInteractor;
@class ShowEntryPresenter;

@interface ShowEntryWireframe : NSObject
@property(nonatomic, strong)ShowEntryInteractor* interactor;
@property(nonatomic, strong)ShowEntryPresenter* presenter;

- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler;

- (void)showNotification:(UILocalNotification*)notification inWindow:(UIWindow *)window;
@end
