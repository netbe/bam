//
//  EntriesCollectionViewController.h
//  bam
//
//  Created by François Benaiteau on 19/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ServiceManager;
@class Entry;

@interface EntriesCollectionViewController : UICollectionViewController
@property(nonatomic, strong)ServiceManager* serviceManager;
@property (nonatomic, copy) void (^selectEntryBlock)(Entry* entry);
@end
