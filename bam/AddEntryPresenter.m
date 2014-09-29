//
//  AddEntryPresenter.m
//  bam
//
//  Created by François Benaiteau on 01/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "AddEntryPresenter.h"

#import "AddEntryInteractor.h"
#import "ListEntryWireframe.h"

#import "EntryNotifier.h"

@interface AddEntryPresenter ()

@end

@implementation AddEntryPresenter

- (NSUInteger)valueForReminderName:(NSString*)name
{
    if ([name isEqualToString:EntryRepetitionSecond]) {
        return 30;
    }else if ([name isEqualToString:EntryRepetitionMinute]) {
        return 5 * 60;
    }else if ([name isEqualToString:EntryRepetitionHour]) {
        return 60 * 60;
    }else if ([name isEqualToString:EntryRepetitionDay]) {
        return 24 * 60 * 60; 
    }else if ([name isEqualToString:EntryRepetitionWeek]) {
        return 7 * 24 * 60 * 60; 
    }else{
        return 0;// EntryRepetitionNever and .*
    }
}

- (NSCalendarUnit)repeatIntervalForReminderName:(NSString*)name
{
    if ([name isEqualToString:EntryRepetitionSecond]) {
        return NSSecondCalendarUnit;
    }else if ([name isEqualToString:EntryRepetitionMinute]) {
        return NSMinuteCalendarUnit;
    }else if ([name isEqualToString:EntryRepetitionHour]) {
        return NSHourCalendarUnit;
    }else if ([name isEqualToString:EntryRepetitionDay]) {
        return NSDayCalendarUnit; 
    }else if ([name isEqualToString:EntryRepetitionWeek]) {
        return NSWeekCalendarUnit; 
    }else{
        return 0;// EntryRepetitionNever and .*
    }
}
- (void)updateCount
{
    NSUInteger count = [self.interactor countEntries];
    [self.view updateCount:count];
}


#pragma mark - AddEventHandler

- (void)prepareNewEntry
{
    self.key = nil;
    self.value = nil;
    self.repeatInterval = nil;
    
    [self.view setKey:nil];
    [self.view setValue:nil];
    [self.view focusOnKey];
    [self updateCount];
}

- (void)updateKey:(NSString*)key
{
    self.key = key;
    [self.view focusOnValue];
}

- (void)updateValue:(NSString*)value
{
    self.value = value;
}

- (void)save
{
//    self.repeatInterval = @([self valueForReminderName:self.view.selectedReminderValue]);
    self.repeatInterval = @([self valueForReminderName:EntryRepetitionMinute]);
    NSCalendarUnit unit = [self repeatIntervalForReminderName:EntryRepetitionMinute];
    NSError* error = nil;
    if ([self.interactor addEntryWithKey:self.key value:self.value period:self.repeatInterval error:&error]) {
        [self.view showSuccess];
        [self updateCount];
        [self.notifier scheduleNotificationWithText:self.key 
                                  intervalInSeconds:self.repeatInterval.doubleValue
                                     repeatInterval:unit];
    }else{
        // might want to *dumbify* error before presenting to user
        [self.view showError:error];
    }
}

- (void)presentListInterface
{
    [self.listWireframe presentListFromViewController:(UIViewController*)self.view interactive:NO];
}
@end
