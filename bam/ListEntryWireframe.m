//
//  ListWireframe.m
//  bam
//
//  Created by François Benaiteau on 23/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "ListEntryWireframe.h"

#import "ListEntryInteractor.h"
#import "ListEntryPresenter.h"
#import "EntriesCollectionViewController.h"
#import "ListInteractiveTransition.h"

@interface ListEntryWireframe ()
@property(nonatomic, strong)EntriesCollectionViewController* listEntriesViewController;
@property(nonatomic, assign)BOOL interactive;
@end


@implementation ListEntryWireframe

- (instancetype)init
{
    self = [super init];
    if (self) {
        _presenter = [[ListEntryPresenter alloc] init];
        
        _listEntriesViewController = [[EntriesCollectionViewController alloc] init];
        _listEntriesViewController.modalPresentationStyle = UIModalPresentationCustom;
        _listEntriesViewController.transitioningDelegate = self;
        _listEntriesViewController.eventHandler = _presenter;
        
        _presenter.listView = _listEntriesViewController;
        _presenter.listWireframe = self;
    }
    return self;
}

- (void)presentListFromViewController:(UIViewController*)viewController interactive:(BOOL)interactive
{
    NSAssert(self.listEntriesViewController, @"listView must be present");
    
    self.presenting = YES;
    [viewController presentViewController:self.listEntriesViewController animated:YES completion:NULL];
}

- (void)dismissListInteractive:(BOOL)interactive
{
    NSAssert(self.listEntriesViewController, @"listView must be present");
    self.presenting = NO;
    [self.listEntriesViewController dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented 
                                                                   presentingController:(UIViewController *)presenting 
                                                                       sourceController:(UIViewController *)source
{
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 2.0;//0.7;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    [self fallingTransition:transitionContext reverse:!self.presenting];
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    if (self.interactive) {
        return self.presenter.interactiveTransition;
    }
    return nil;

}

- (void)animationEnded:(BOOL) transitionCompleted
{
    
}
#pragma mark -

- (void)fallingTransition:(id <UIViewControllerContextTransitioning>)transitionContext reverse:(BOOL)reverse
{
    UIViewController* from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor blueColor];
    if (from.view.superview != containerView) {
        [containerView addSubview:from.view]; 
    }
    
    [containerView addSubview:to.view];
    
    if (reverse) {
        // move toView off bottom of the screen 
        to.view.frame = CGRectOffset(to.view.frame, 0, CGRectGetHeight(containerView.bounds));
    }else{
        // move toView off top of the screen 
        to.view.frame = CGRectOffset(to.view.frame, 0, - CGRectGetHeight(containerView.bounds));    
    }
    
    
    CGRect initialFromFrame = from.view.frame;
    CGRect initialToFrame = to.view.frame;
    
    CGRect finalFromFrame = reverse ? CGRectOffset(initialFromFrame, 0, - CGRectGetHeight(containerView.bounds)) : CGRectOffset(initialFromFrame, 0, CGRectGetHeight(containerView.bounds));    
    CGRect finalToFrame = initialFromFrame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0 usingSpringWithDamping:0.7
          initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseIn 
                     animations:^{
                         to.view.frame = finalToFrame;
                         from.view.frame = finalFromFrame;
                     } completion:^(BOOL finished) {
                         BOOL cancel = [transitionContext transitionWasCancelled];
                         if (cancel) {
                             from.view.frame = initialToFrame;
                             [to.view removeFromSuperview];
                         }else{
                             [from.view removeFromSuperview];
                         }
                         
                         [transitionContext completeTransition:!cancel];
                     }];
}
@end
