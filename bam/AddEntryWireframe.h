//
//  EntryWireframe.h
//  bam
//
//  Created by François Benaiteau on 01/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddEntryInteractor;
@class AddEntryPresenter;

/// to add interface
@interface AddEntryWireframe : NSObject

@property(nonatomic, strong)AddEntryPresenter* presenter;
@property(nonatomic, strong)AddEntryInteractor* interactor;


- (void)presentAddInterfaceFromViewController:(UIViewController*)viewController;

- (void)presentAddInterfaceFromWindow:(UIWindow *)window;
@end
