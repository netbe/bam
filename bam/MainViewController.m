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
#import "Entry.h"

@interface MainViewController ()
@property(nonatomic, strong)EntryViewController* entryViewController;
@property(nonatomic, strong)EntryViewController* modalEntryViewController;
@property(nonatomic, strong)EntriesCollectionViewController* collectionViewController;
@property(nonatomic, strong)UISwipeGestureRecognizer* swipeGesture;
@end

@implementation MainViewController
-(void)presentEntryInModalWithEntry:(Entry*)entry
{
    EntryViewController* vc = EntryViewController.new;
    vc.key = entry.key;
    vc.value = entry.value;
    vc.repeatInterval = entry.repeatInterval;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];

    [vc.view didMoveToSuperview];
    vc.view.frame = (CGRect){ .size = {300, 300}};
    vc.view.center = self.view.center;
    self.modalEntryViewController = vc;
    //    [weakSelf presentViewController:vc animated:YES completion:nil];
}
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
        __weak __typeof(&*self)weakSelf = self;
        _collectionViewController.selectEntryBlock = ^(Entry* entry){
            [weakSelf presentEntryInModalWithEntry:entry];
        };
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
    if (self.modalEntryViewController) {
        [self.modalEntryViewController removeFromParentViewController];
        [self.modalEntryViewController.view removeFromSuperview];
        self.modalEntryViewController = nil;
    }
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
