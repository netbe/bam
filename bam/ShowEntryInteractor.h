//
//  ShowEntryInteractor.h
//  bam
//
//  Created by François Benaiteau on 28/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EntryDataStore;
@class EntryNotifier;

@interface ShowEntryInteractor : NSObject
@property(nonatomic, strong)EntryDataStore* dataStore;
@property(nonatomic, strong)EntryNotifier* notifier;
-(id)initWithDataManager:(EntryDataStore*)dataStore notifier:(EntryNotifier*)entryNotifier;
@end
