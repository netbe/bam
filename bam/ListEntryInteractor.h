//
//  ListEntryInteractor.h
//  bam
//
//  Created by François Benaiteau on 01/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EntryDataStore;

@interface ListEntryInteractor : NSObject
-(id)initWithDataManager:(EntryDataStore*)dataStore;
-(NSArray*)findEntries;

@end
