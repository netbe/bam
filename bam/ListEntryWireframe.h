//
//  ListEntryWireframe.h
//  bam
//
//  Created by François Benaiteau on 23/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ListEntryInteractor;
@class ListEntryPresenter;


@interface ListEntryWireframe : NSObject<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property(nonatomic, strong)ListEntryInteractor* interactor;
@property(nonatomic, strong)ListEntryPresenter* presenter;

@property(nonatomic, assign)BOOL presenting;// NO means dismissing

- (void)presentListFromViewController:(UIViewController*)viewController;
- (void)dismissList;
@end
