//
//  ServiceManager.m
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "ServiceManager.h"

@implementation ServiceManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

- (Entry*)createEntryWithKey:(NSString*)key value:(NSString*)value
{
    NSAssert(self.coreDataStack.mainContext, @"context should not be nil");
    Entry* entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:self.coreDataStack.mainContext];
    entry.key = key;
    entry.value = value;
    return entry;
}

- (void)setupCoreData
{
    self.coreDataStack = [[CoreDataStack alloc] initWithFilename:@"bam.sqlite" options:CoreDataStackForceRemoveFileOption];
    NSError* error =  nil;
    BOOL success = [self.coreDataStack setup:&error];
    if (!success) {
        NSLog(@"error setupCoreData: %@", error);
    }
}

- (void)applicationWillResignActive:(NSNotification*)notification
{
    NSError* error = nil;
    BOOL save = [self.coreDataStack.mainContext save:&error];
    if (!save) {
        NSLog(@"error %@",error);
    }
    
}

@end
