//
//  ListEntryInteractor.m
//  bam
//
//  Created by François Benaiteau on 01/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "ListEntryInteractor.h"

#import "EntryDataStore.h"
#import "Entry.h"
#import "Entry+BAMAdditions.h"

@interface ListEntryInteractor ()
@property(nonatomic, strong)EntryDataStore* dataStore;
@end

@implementation ListEntryInteractor

-(id)initWithDataManager:(EntryDataStore*)dataStore
{
    self = [super init];
    if (self) {
        self.dataStore = dataStore;
    }
    return self;
}

-(NSArray<PlainEntry*>*)findEntries
{
    NSMutableArray* plainEntries = [[NSMutableArray alloc] init];
    NSArray* entries = [self.dataStore findAllEntriesWithError:NULL];
    for (Entry* entry in entries) {
        PlainEntry* plainEntry = [entry plainEntry];
        if(plainEntry) {
            [plainEntries addObject:entry.plainEntry];
        }
    }
    return plainEntries;
}
@end
