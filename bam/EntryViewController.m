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
@property(nonatomic, copy)NSString* key;
@property(nonatomic, copy)NSString* value;
@end

@implementation EntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self newEntry];
}
#pragma mark - 

- (void)newEntry
{
    self.entryView.keyInputView.text = @"";
    self.entryView.valueInputView.text = @"";
    self.key = nil;
    self.value = nil;
    [self.entryView becomeFirstResponder];
}
- (void)saveEntry
{
    self.key = self.entryView.keyInputView.text;
    self.value = self.entryView.valueInputView.text;
    NSLog(@"entry saved %@ : %@", self.key, self.value);
    // TODO: save to coredata
    id entity = [self.serviceManager createEntryWithKey:self.key value:self.value];
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
