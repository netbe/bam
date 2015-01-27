//
//  RootWireframe.h
//  bam
//
//  Created by François Benaiteau on 01/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddEntryInteractor;
@class AddEntryPresenter;

@interface RootWireframe : NSObject
@property(nonatomic, strong)UIWindow* window;

@property(nonatomic, strong)AddEntryPresenter* presenter;
@property(nonatomic, strong)AddEntryInteractor* interactor;

-(void)setup;

- (void)presentEntryFromNotification:(NSNotification*)notification;
@end
