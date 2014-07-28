//
//  EntriesCollectionViewController.h
//  bam
//
//  Created by François Benaiteau on 19/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ListEntryPresenter.h"

@interface EntriesCollectionViewController : UICollectionViewController<ListView>
@property(nonatomic, strong)id<ListEventHandler> eventHandler;
@end
