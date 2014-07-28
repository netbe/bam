//
//  EntriesCollectionViewController.m
//  bam
//
//  Created by François Benaiteau on 19/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//
#import "EntriesCollectionViewController.h"

@import CoreData;
#import "ServiceManager.h"
#import "EntryCell.h"

static NSString* const kCellIdentifier = @"com.bam.cell";

@interface EntriesCollectionViewController ()<NSFetchedResultsControllerDelegate>
@property(nonatomic, strong)NSFetchedResultsController* resultsController;
@property(nonatomic, strong)UIButton* addModeButton;
@end

@implementation EntriesCollectionViewController

- (id)init
{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(145, 100)];
    [flowLayout setMinimumInteritemSpacing:5];
    [flowLayout setMinimumLineSpacing:5];
    flowLayout.sectionInset = UIEdgeInsetsMake(5,5,5,5);
    self = [super initWithCollectionViewLayout:flowLayout];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{    
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    NSAssert(self.eventHandler, @"must have a eventHandler");
    [self.eventHandler addGestureToView:self.view];
    [self.collectionView registerClass:[EntryCell class] forCellWithReuseIdentifier:kCellIdentifier];
    
    self.addModeButton = [[UIButton alloc] init];
    [self.view addSubview:self.addModeButton];
    [self.addModeButton setTitle:@"+" forState:UIControlStateNormal];
    [self.addModeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addModeButton addTarget:self action:@selector(addModeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.addModeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_addModeButton(44)]|"
                                                                      options:0 metrics:nil 
                                                                        views:NSDictionaryOfVariableBindings(_addModeButton)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_addModeButton(44)]|"
                                                                      options:0 metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_addModeButton)]];

}

- (void)addModeButtonTapped:(id)sender
{
    [self.eventHandler dismissList];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;//self.resultsController.fetchedObjects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EntryCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    return cell;
}

@end
