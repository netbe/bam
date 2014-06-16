//
//  EntryViewController.m
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "EntryViewController.h"

#import "EntryView.h"

#import "ServiceManager.h"


@interface EntryViewController ()<UITextFieldDelegate>
@property(nonatomic, weak)EntryView* entryView;

@end

@implementation EntryViewController

- (void)loadView
{
    EntryView* entryView = EntryView.new;
    entryView.keyInputView.delegate = self;
    entryView.valueInputView.delegate = self;
    self.view = entryView;
    self.entryView = entryView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.entryView.saveButton addTarget:self
                                  action:@selector(saveEntry)
                        forControlEvents:UIControlEventTouchUpInside];
    if (!(self.key || self.value)) {
        [self newEntry];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.entryView.keyInputView.text = self.key;
    self.entryView.valueInputView.text = self.value;
//    NSString* selected = [self.entryView.reminderValues indexOfObject:self.repeatInterval];
//    [self.entryView.reminderControl.selectedSegmentIndex];
//    self.entryView.reminderControl.selectedSegmentIndex = self.repeatInterval;

}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.entryView resignFirstResponder];
}
#pragma mark -

- (void)newEntry
{
    self.entryView.keyInputView.text = @"";
    self.entryView.valueInputView.text = @"";
    self.key = nil;
    self.value = nil;
//    [self.entryView becomeFirstResponder];
}

- (void)saveEntry
{
    self.key = self.entryView.keyInputView.text;
    self.value = self.entryView.valueInputView.text;
    NSLog(@"entry saved %@ : %@", self.key, self.value);
    // save to coredata
    NSString* selected = self.entryView.reminderValues[self.entryView.reminderControl.selectedSegmentIndex];
    NSUInteger repeatInterval =  0;
    if ([selected isEqualToString:EntryRepetitionSecond]) {
        repeatInterval = NSCalendarUnitSecond;
    }else if ([selected isEqualToString:EntryRepetitionMinute]){
        repeatInterval = NSCalendarUnitMinute;
    }else if ([selected isEqualToString:EntryRepetitionHour]){
        repeatInterval = NSCalendarUnitHour;
    }else if ([selected isEqualToString:EntryRepetitionDay]){
        repeatInterval = NSCalendarUnitDay;
    }else if ([selected isEqualToString:EntryRepetitionWeek]){
        repeatInterval = NSCalendarUnitWeekday;
    }
    
    id entity = [self.serviceManager createEntryWithKey:self.key value:self.value repeatInterval:repeatInterval];
    if (entity) {
        [self newEntry];
    }else{
        NSLog(@"error cannot saveEntry");
        [self.entryView becomeFirstResponder];
    }
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.entryView.keyInputView) {
        [self.entryView.valueInputView becomeFirstResponder];
    }
    else if (textField == self.entryView.valueInputView) {
        [self saveEntry];
    }
    [textField resignFirstResponder];
    return YES;
}

@end
