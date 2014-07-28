//
//  ListInteractiveTransition.h
//  bam
//
//  Created by François Benaiteau on 26/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListInteractiveTransition : UIPercentDrivenInteractiveTransition
@property(nonatomic, strong)UIView* view;
@property (nonatomic, copy) void (^dismissListBlock)();
@end
