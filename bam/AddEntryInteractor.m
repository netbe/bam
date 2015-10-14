//
//  AddEntryInteractor.m
//  bam
//
//  Created by François Benaiteau on 30/06/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "AddEntryInteractor.h"

#import "EntryDataStore.h"
#import "Entry.h"

@interface AddEntryInteractor ()
@property(nonatomic, strong, readwrite)EntryDataStore* dataStore;
@end

@implementation AddEntryInteractor

-(id)initWithDataManager:(EntryDataStore*)dataStore
{
    self = [super init];
    if (self) {
        self.dataStore = dataStore;
    }
    return self;
}

-(BOOL)addEntryWithKey:(NSString*)key value:(NSString*)value level:(id)level error:(NSError**)pError
{
    return [self.dataStore entryWithAddBlock:^(Entry *entry) {
        entry.key = key;
        entry.value = value;
        entry.level = level;
    } error:pError];
}

-(NSUInteger)countEntries
{
    return [self.dataStore countEntriesWithError:NULL];
}
@end
