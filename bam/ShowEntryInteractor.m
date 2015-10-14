//
//  ShowEntryInteractor.m
//  bam
//
//  Created by François Benaiteau on 28/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import "ShowEntryInteractor.h"

#import "EntryDataStore.h"
#import "EntryNotifier.h"
#import "PlainEntry.h"
#import "PlainLevel.h"
#import "Entry.h"

@implementation ShowEntryInteractor

- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification
{
    if ([identifier isEqualToString:EntryNotifierNotificationCategoryDefinitionAction]) {

        PlainEntry* entry = [PlainEntry entryFromPayload:notification.userInfo];
        PlainLevel* nextLevel = [entry.level nextLevel];
        // update model
        NSError* error = nil;
        BOOL success = [self.dataStore entryWithKey:entry.key updateBlock:^(Entry *entry) {
            entry.level = nextLevel;
            entry.learned = @(nextLevel == nil);
        } error:&error];
        if (!success) {
            NSLog(@"Error: %@", error.localizedDescription);
        }else{
            // cancel notification
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            // schedule next reminder
            if (nextLevel) {
                [self.notifier scheduleNotificationWithText:entry.textForNotification
                                                   category:EntryNotifierNotificationCategoryDefinition
                                          intervalInSeconds:nextLevel.timeInterval
                                             repeatInterval:nextLevel.repeatTimeInterval
                                                   userInfo:entry.dictionaryRepresentation];
            }
        }
    }
}

-(id)initWithDataManager:(EntryDataStore*)dataStore notifier:(EntryNotifier*)entryNotifier
{
    self = [super init];
    if (self) {
        self.dataStore = dataStore;
        self.notifier = entryNotifier;
    }
    return self;
}

@end
