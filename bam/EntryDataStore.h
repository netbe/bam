//
//  EntryDataManager.h
//  bam
//
//  Created by François Benaiteau on 30/06/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStack;
@class Entry;

typedef void (^EntryBlock)(Entry* entry);


@interface EntryDataStore : NSObject
@property(nonatomic, strong, readonly)CoreDataStack* coreDataStack;

-(instancetype)initWithCoreDataStack:(CoreDataStack*)coreDataStack;

-(Entry*)findEntryWithKey:(NSString*)key error:(NSError**)pError;
-(NSArray*)findAllEntriesWithError:(NSError**)pError;
-(NSUInteger)countEntriesWithError:(NSError**)pError;
-(BOOL)entryWithAddBlock:(EntryBlock)addBlock error:(NSError**)pError;
-(BOOL)entryWithKey:(NSString*)key updateBlock:(EntryBlock)updateBlock error:(NSError**)pError;
-(BOOL)deleteEntryWithKey:(NSString*)key error:(NSError**)pError;

@end
