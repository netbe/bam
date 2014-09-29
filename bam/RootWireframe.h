//
//  RootWireframe.h
//  bam
//
//  Created by François Benaiteau on 01/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class EntryViewController;
@class AddEntryInteractor;
@class AddEntryPresenter;
@class EntryNotifier;

@interface RootWireframe : NSObject
@property(nonatomic, strong)UIWindow* window;

//@property(nonatomic, strong)EntryViewController* entryViewController;
@property(nonatomic, strong)AddEntryPresenter* presenter;
@property(nonatomic, strong)AddEntryInteractor* interactor;
@property(nonatomic, strong)EntryNotifier* notifier;
-(void)setup;
@end
