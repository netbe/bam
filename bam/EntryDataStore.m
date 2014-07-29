//
//  EntryDataManager.m
//  bam
//
//  Created by François Benaiteau on 30/06/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "EntryDataStore.h"

#import "CoreDataStack.h"
#import "Entry.h"

@interface EntryDataStore ()
@property(nonatomic, strong, readwrite)CoreDataStack* coreDataStack;

@end

@implementation EntryDataStore

-(id)init
{
    self = [super init];
    if (self) {
        self.coreDataStack = [[CoreDataStack alloc] init];
        [self.coreDataStack setup:NULL];
    }
    return self;
}

-(instancetype)initWithCoreDataStack:(CoreDataStack*)coreDataStack
{
    self = [super init];
    if (self) {
        self.coreDataStack = coreDataStack;
    }
    return self;
}

#pragma mark -

-(NSArray*)findAllEntriesWithError:(NSError**)pError
{
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Entry"];
    NSError* error = nil;
    NSArray* results = [self.coreDataStack.mainContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"🔥%@ in %s", error, __PRETTY_FUNCTION__);
    }
    return results;
}

-(Entry*)findEntryWithKey:(NSString*)key error:(NSError**)pError
{
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Entry"];
    request.predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"key", key];
    NSError* error = nil;
    NSArray* results = [self.coreDataStack.mainContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"🔥%@ in %s", error, __PRETTY_FUNCTION__);
    }
    return results.firstObject;
}

-(BOOL)entryWithAddBlock:(EntryBlock)addBlock error:(NSError**)pError
{
    Entry* entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:self.coreDataStack.mainContext];
    if (addBlock) {
        addBlock(entry);
    }
    BOOL success = [self saveMainContextWithError:pError];
    if (!success) {
        // we fail saving, cleanup object, as we will retry same operation
        [self.coreDataStack.mainContext deleteObject:entry];
    }
    return success;
}

-(BOOL)entryWithKey:(NSString*)key updateBlock:(EntryBlock)updateBlock error:(NSError**)pError
{
    Entry* entry = [self findEntryWithKey:key error:pError];
    if (updateBlock) {
        updateBlock(entry);
    }
    return [self saveMainContextWithError:pError];
}

-(BOOL)deleteEntryWithKey:(NSString*)key error:(NSError**)pError
{
    Entry* entry = [self findEntryWithKey:key error:pError];
    if (entry) {
        [self.coreDataStack.mainContext deleteObject:entry];
        return [self saveMainContextWithError:pError];
    }
    return NO;
    
}

#pragma mark - Private

-(BOOL)saveMainContextWithError:(NSError**)pError
{
    if(![self.coreDataStack.mainContext save:pError]){
        NSLog(@"🔥%@ in %s", *pError, __PRETTY_FUNCTION__);
        return NO;
    }
    return YES;
}

@end