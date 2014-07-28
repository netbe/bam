//
//  ListInteractiveTransition.m
//  bam
//
//  Created by François Benaiteau on 26/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "ListInteractiveTransition.h"


@interface ListInteractiveTransition ()
@property(nonatomic, assign)BOOL shouldFinishAnimation;
@end

@implementation ListInteractiveTransition

- (void)setView:(UIView *)view
{
    _view = view;
    UISwipeGestureRecognizer* gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self 
                                                                                  action:@selector(pinching:)];
    gesture.direction = UISwipeGestureRecognizerDirectionUp;
    [view addGestureRecognizer:gesture];
}

- (CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)pinching:(UISwipeGestureRecognizer*)gesture
{
//    if (self.dismissListBlock) {
//        self.dismissListBlock();
//    }
//    return;

    CGPoint point = [gesture locationInView:gesture.view];
    static CGPoint lastPoint;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            lastPoint.y = -1;
            
            if (point.y > CGRectGetMidY(gesture.view.bounds)) {
                if (self.dismissListBlock) {
                    self.dismissListBlock();
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {   
            if (lastPoint.x == -1) {
                lastPoint = point;
            }
            CGFloat deltaY = lastPoint.y - point.y;
            CGFloat complete = deltaY / CGRectGetHeight(gesture.view.frame);

                self.shouldFinishAnimation = (complete < 0.5);


            [self updateInteractiveTransition:complete];
            break;
        }
        case UIGestureRecognizerStateEnded:
            if (self.shouldFinishAnimation) {
                [self finishInteractiveTransition];
            }

            break;
        case UIGestureRecognizerStateCancelled:
            [self cancelInteractiveTransition];
            break;
        default:
            break;
    }
}

@end
