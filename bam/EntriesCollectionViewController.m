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
        self.collectionView.backgroundColor = [UIColor greenColor];
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.collectionView registerClass:[EntryCell class] forCellWithReuseIdentifier:kCellIdentifier];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.resultsController) {
        self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:[Entry fetchRequest]
                                                                     managedObjectContext:self.serviceManager.coreDataStack.mainContext
                                                                       sectionNameKeyPath:nil
                                                                                cacheName:nil];
    }
    
    NSError* error = nil;
    [self.resultsController performFetch:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.resultsController.fetchedObjects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Entry* entry = [self.resultsController objectAtIndexPath:indexPath];
    EntryCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.keyLabel.text = entry.key;
    cell.valueLabel.text = entry.value;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Entry* entry = [self.resultsController objectAtIndexPath:indexPath];
    if (self.selectEntryBlock) {
        self.selectEntryBlock(entry);
    }
}
@end
