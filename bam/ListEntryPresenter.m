//
//  ListEntryPresenter.m
//  bam
//
//  Created by François Benaiteau on 23/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "ListEntryPresenter.h"

#import "ListEntryWireframe.h"
#import "ListInteractiveTransition.h"

@implementation ListEntryPresenter

- (void)addGestureToView:(UIView*)view
{
    self.interactiveTransition = [[ListInteractiveTransition alloc] init];
    __weak __typeof(&*self)weakSelf = self;
    NSAssert(self.listWireframe, @"should not be nil");
    self.interactiveTransition.dismissListBlock = ^{
        [weakSelf.listWireframe dismissListInteractive:YES];
    };
    self.interactiveTransition.view = view;
}

- (void)dismissList
{
    [self.listWireframe dismissListInteractive:NO];
}
@end
