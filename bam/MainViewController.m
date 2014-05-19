//
//  MainViewController.m
//  bam
//
//  Created by François Benaiteau on 19/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "MainViewController.h"

#import "EntryViewController.h"
#import "EntriesCollectionViewController.h"


@interface MainViewController ()
@property(nonatomic, strong)EntryViewController* entryViewController;
@property(nonatomic, strong)EntriesCollectionViewController* collectionViewController;
@property(nonatomic, strong)UISwipeGestureRecognizer* swipeGesture;
@end

@implementation MainViewController

- (EntryViewController *)entryViewController
{
    if (!_entryViewController) {
        _entryViewController = EntryViewController.new;
        _entryViewController.serviceManager = self.serviceManager;
    }
    return _entryViewController;
}

- (EntriesCollectionViewController *)collectionViewController
{
    if (!_collectionViewController) {
        _collectionViewController = EntriesCollectionViewController.new;
        _collectionViewController.serviceManager = self.serviceManager;
    }
    return _collectionViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(switchViewController:)];
    self.swipeGesture.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;

    [self showViewController:self.entryViewController];
}

- (void)showViewController:(UIViewController*)viewController
{
    [self.view addSubview:viewController.view];
    NSDictionary* views = NSDictionaryOfVariableBindings(viewController.view);
    for (UIView* view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(5)-[view]-(5)-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(view)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(view)]];
        
    }
    
    [viewController.view addGestureRecognizer:self.swipeGesture];

}

- (void)switchViewController:(UISwipeGestureRecognizer*)swipeGesture
{
    if (swipeGesture.view == self.entryViewController.view) {
        // show collection
        [self.entryViewController.view removeFromSuperview];
        [self showViewController:self.collectionViewController];
    }else{
                [self.collectionViewController.view removeFromSuperview];
        [self showViewController:self.entryViewController];
    }
}

@end
