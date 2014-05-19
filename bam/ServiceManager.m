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

- (EntryNotifier *)notifier
{
    if (!_notifier) {
        _notifier = [[EntryNotifier alloc] init];
    }
    return _notifier;
}

- (Entry*)createEntryWithKey:(NSString*)key value:(NSString*)value repeatInterval:(NSCalendarUnit)repeatInterval
{
    NSAssert(self.coreDataStack.mainContext, @"context should not be nil");
    Entry* entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:self.coreDataStack.mainContext];
    entry.key = key;
    entry.value = value;
    entry.repeatInterval = @(repeatInterval);
    return entry;
}

- (void)scheduleEntry:(Entry*)entry
{
    NSString* alert = [NSString stringWithFormat:@"%@ : %@", entry.key, entry.value];
    if (entry.repeatInterval.integerValue == 0) {
        // skip notification
    }else{
        [self.notifier scheduleNotificationWithText:alert
                                     repeatInterval:entry.repeatInterval.integerValue];
    }
}

- (void)scheduleEntryNotifications
{
    for (Entry* entry in [Entry fetchEntriesInContext:self.coreDataStack.mainContext]) {
        if(entry.isInserted){
            [self scheduleEntry:entry];
        }else if (entry.isUpdated){
            // TODO: handle repeatInterval changed
        }
    }
}

- (void)setupCoreData
{
    self.coreDataStack = [[CoreDataStack alloc] initWithFilename:@"bam.sqlite" options:CoreDataStackNoneOption];
    NSError* error =  nil;
    BOOL success = [self.coreDataStack setup:&error];
    if (!success) {
        NSLog(@"error setupCoreData: %@", error);
    }
}

- (void)persistCurrentEntries
{
    NSError* error = nil;
    BOOL save = [self.coreDataStack.mainContext save:&error];
    if (!save) {
        NSLog(@"error %@",error);
    }
}

- (void)applicationWillResignActive:(NSNotification*)notification
{
//    __block UIBackgroundTaskIdentifier bgTask = [[UIApplication sharedApplication]  beginBackgroundTaskWithExpirationHandler:^{
        [self persistCurrentEntries];
        [self scheduleEntryNotifications];
//        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
//    }];
}

@end
