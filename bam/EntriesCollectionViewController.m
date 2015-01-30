//
//  EntriesCollectionViewController.m
//  bam
//
//  Created by François Benaiteau on 19/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//
#import "EntriesCollectionViewController.h"

#import "EntryCell.h"
#import "PlainLevel.h"

static NSString* const kCellEntryIdentifier = @"com.bam.cell.entry";
static NSString* const kCellAddIdentifier = @"com.bam.cell.add";

@interface PlainEntry (UI)
-(UIColor*)borderColor;
@end

@implementation PlainEntry (UI)

-(UIColor*)borderColor
{
    switch (self.level.difficulty) {
        case 1:
            // R: 241, G: 241, B: 241
            return [UIColor colorWithRed:241 green:241 blue:241 alpha:1.0];
            break;
        case 2:
            // R: 191, G: 221, B: 194
            return [UIColor colorWithRed:191 green:221 blue:194 alpha:1.0];
            break;
        case 3:
            // R: 141, G: 202, B: 147
            return [UIColor colorWithRed:141 green:202 blue:147 alpha:1.0];
            break;
        case 4:
            // R: 91, G: 182, B: 100
            return [UIColor colorWithRed:91 green:182 blue:100 alpha:1.0];
            break;
        case 5:
            // R: 41, G: 163, B: 54
            return [UIColor colorWithRed:41 green:163 blue:54 alpha:1.0];
            break;
        default:
            break;
    }
    return nil;
}

@end

@interface EntriesCollectionViewController ()
@property(nonatomic, strong)NSArray* entries;
@property(nonatomic, assign)BOOL displayAddButton;
@property(nonatomic, strong)UIButton* addModeButton;
@end

@implementation EntriesCollectionViewController

- (id)init
{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(310, 100)];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:5];
    flowLayout.sectionInset = UIEdgeInsetsMake(20,5,0,5);
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
    [self.collectionView registerClass:[EntryCell class] forCellWithReuseIdentifier:kCellEntryIdentifier];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellAddIdentifier];

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.eventHandler updateView];
}

#pragma mark - ListView

- (void)displayAddEntryButton:(BOOL)display
{
    self.displayAddButton = display;
    self.addModeButton.hidden = display;    
}

- (void)setEntries:(NSArray*)entries
{
    _entries = entries;
    [self.collectionView reloadData];
}

- (void)configureEntryCell:(EntryCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    PlainEntry* entry = self.entries[indexPath.row];
    cell.keyLabel.text = entry.key.capitalizedString;
    cell.valueLabel.text = entry.value;
    [cell setBorderColor:[entry borderColor]];
}


- (void)addModeButtonTapped:(id)sender
{
    [self.eventHandler dismissList];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSUInteger count = self.displayAddButton ? 1 : 0;
    return self.entries.count + count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell;
    if (indexPath.row == self.entries.count) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellAddIdentifier forIndexPath:indexPath];
        // add Button
        UILabel* addEntry = [[UILabel alloc] init];
        addEntry.text = @"+";
        addEntry.font = [UIFont systemFontOfSize:20];
        addEntry.textColor = [UIColor blackColor];
        [addEntry sizeToFit];
        
        [cell.contentView addSubview:addEntry];
        addEntry.center = cell.contentView.center;
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellEntryIdentifier forIndexPath:indexPath];
        [self configureEntryCell:(EntryCell*)cell atIndexPath:indexPath];
    }   
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.entries.count) {
        // add Button
        [self.eventHandler dismissList];
    }else{
        [self.eventHandler selectEntry:self.entries[indexPath.row]];
    }
}

@end
