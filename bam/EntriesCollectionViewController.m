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
    self.collectionView.backgroundColor = [UIColor greenColor];
    
    NSAssert(self.eventHandler, @"must have a eventHandler");
    [self.eventHandler addGestureToView:self.view];
    [self.collectionView registerClass:[EntryCell class] forCellWithReuseIdentifier:kCellIdentifier];
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
