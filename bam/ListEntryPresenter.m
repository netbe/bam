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
    self.interactiveTransition.dismissListBlock = ^{
        NSAssert(weakSelf.listWireframe, @"should not be nil");
        [weakSelf.listWireframe dismissList];
    };
    self.interactiveTransition.view = view;
}
@end
