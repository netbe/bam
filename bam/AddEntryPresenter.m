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

@interface AddEntryPresenter ()<UIAlertViewDelegate>

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
    NSCalendarUnit unit = [self repeatIntervalForReminderName:EntryRepetitionSecond];
    //    self.repeatInterval = @([self valueForReminderName:self.view.selectedReminderValue]);
    self.repeatInterval = @([self valueForReminderName:EntryRepetitionSecond]);
    NSError* error = nil;
    if ([self.interactor addEntryWithKey:self.key value:self.value period:self.repeatInterval error:&error]) {
        [self.view showSuccess];
        [self updateCount];
    }else{
        // might want to *dumbify* error before presenting to user
        [self.view showError:error];
    }
}

- (void)showPreAuthorizationDialog
{
    [[[UIAlertView alloc] initWithTitle:@"BAM" message:@"Do you want to use notifications to remind you entries?" delegate:self cancelButtonTitle:@"No, thanks" otherButtonTitles:@"Sure!", nil] show];
}

- (void)scheduleNotification
{
    if ([self.notifier shouldAskNotificationPermissions]) {
        [self showPreAuthorizationDialog];
    }else{
        NSCalendarUnit unit = [self repeatIntervalForReminderName:EntryRepetitionSecond];
        [self.notifier scheduleNotificationWithText:[self definitionTextForNotification] 
                                  intervalInSeconds:self.repeatInterval.doubleValue
                                     repeatInterval:unit];
    }
}

- (NSString*)definitionTextForNotification
{
    return [NSString stringWithFormat:@"'%@' = '%@'", self.key, self.value];
}


- (void)presentListInterface
{
    [self.listWireframe presentListFromViewController:(UIViewController*)self.view interactive:NO];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        [self.notifier authorizeNotifications:NO];
    }else{
        [self.notifier authorizeNotifications:YES];
        [self scheduleNotification];
    }
}
@end
