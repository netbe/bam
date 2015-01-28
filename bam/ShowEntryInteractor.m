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
#import "NotificationHelper.h"
#import "PlainEntry.h"
#import "Entry.h"

@implementation ShowEntryInteractor

- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification
{
    if ([identifier isEqualToString:EntryNotifierNotificationCategoryDefinitionAction]) {

        PlainEntry* entry = [PlainEntry entryFromPayload:notification.userInfo];
        // update model
        NSError* error = nil;
        NSNumber* nextRepeatTime = [NotificationHelper nextRepeatIntervalForUnit:notification.repeatInterval];
        BOOL success = [self.dataStore entryWithKey:entry.key updateBlock:^(Entry *entry) {
            entry.repeatInterval = nextRepeatTime;
            entry.learned = @(nextRepeatTime == nil);
        } error:&error];
        if (!success) {
            NSLog(@"Error: %@", error.localizedDescription);
        }else{
            // cancel notification
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            // schedule next reminder
            if (nextRepeatTime) {
                [self.notifier scheduleNotificationWithText:entry.definitionTextForNotification category:EntryNotifierNotificationCategoryDefinition intervalInSeconds:Not] repeatInterval:<#(NSCalendarUnit)#> userInfo:<#(NSDictionary *)#>]
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
