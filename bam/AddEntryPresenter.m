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
#import "PlainEntry.h"
#import "NotificationHelper.h"

@interface AddEntryPresenter ()<UIAlertViewDelegate>

@end

@implementation AddEntryPresenter


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
    NSCalendarUnit unit = [NotificationHelper repeatIntervalForReminderName:EntryRepetitionSecond];
    //    self.repeatInterval = @([self valueForReminderName:self.view.selectedReminderValue]);
    self.repeatInterval = @([NotificationHelper valueForReminderName:EntryRepetitionSecond]);
    NSError* error = nil;
    if ([self.interactor addEntryWithKey:self.key value:self.value period:self.repeatInterval error:&error]) {
        [self.view showSuccess];
        [self updateCount];
    }else{
        // might want to *dumbify* error before presenting to user
        [self.view showError:error];
    }
}

- (void)didSaveEntry
{
    if ([self.notifier shouldAskNotificationPermissions]) {
        [self showPreAuthorizationDialog];
    }else{
        [self scheduleNotification];
        [self prepareNewEntry];
    }
}

- (void)showPreAuthorizationDialog
{
    [[[UIAlertView alloc] initWithTitle:@"BAM" message:@"Do you want to use notifications to remind you entries?" 
                               delegate:self cancelButtonTitle:@"No, thanks" 
                      otherButtonTitles:@"Sure!", nil] show];
}

- (void)scheduleNotification
{
    PlainEntry* entry = [PlainEntry entryWithKey:self.key value:self.value];
    entry.type = EntryTypeDefinition;
    NSCalendarUnit unit = [NotificationHelper repeatIntervalForReminderName:EntryRepetitionSecond];
    [self.notifier scheduleNotificationWithText:[entry definitionTextForNotification] 
                                       category:EntryNotifierNotificationCategoryDefinition
                              intervalInSeconds:self.repeatInterval.doubleValue
                                 repeatInterval:unit
                                       userInfo:entry.dictionaryRepresentation];
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
