  //
//  ListInteractiveTransition.m
//  bam
//
//  Created by François Benaiteau on 26/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "ListInteractiveTransition.h"


@interface ListInteractiveTransition ()
@property(nonatomic, strong)UIPinchGestureRecognizer* gesture;
@end

@implementation ListInteractiveTransition

- (void)setView:(UIView *)view
{
    _view = view;
    UISwipeGestureRecognizer* gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self 
                                                                                  action:@selector(pinching:)];
    gesture.direction = UISwipeGestureRecognizerDirectionDown;
    [view addGestureRecognizer:gesture];
}

- (void)pinching:(UISwipeGestureRecognizer*)gesture
{
    if (self.dismissListBlock) {
        self.dismissListBlock();
    }
    return;
    CGPoint point = [gesture locationInView:gesture.view];
    static CGPoint lastPoint;
    switch (gesture.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:
            lastPoint = CGPointZero;
            
            if (self.dismissListBlock) {
                self.dismissListBlock();
            }
            break;
            
        case UIGestureRecognizerStateChanged:
        {   
            CGFloat complete = 1.0 - (point.y / CGRectGetHeight(gesture.view.frame));
            if (complete < 0.5) {
                
            }

            [self updateInteractiveTransition:complete];
            break;
        }
        case UIGestureRecognizerStateEnded:
            [self finishInteractiveTransition];
            break;
        case UIGestureRecognizerStateCancelled:
            [self cancelInteractiveTransition];
            break;
        case UIGestureRecognizerStateFailed:
            break;
        default:
            break;
    }
}

@end
