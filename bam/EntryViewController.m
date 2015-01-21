//
//  EntryViewController.m
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "EntryViewController.h"

#import "InputView.h"
static CGFloat kAlertDismissTimeout = 2.0;

NSString * const EntryRepetitionNever = @"never";
NSString * const EntryRepetitionSecond = @"second";
NSString * const EntryRepetitionMinute = @"minute";
NSString * const EntryRepetitionHour = @"hourly";
NSString * const EntryRepetitionDay = @"daily";
NSString * const EntryRepetitionWeek = @"weekly";

@interface EntryViewController ()<UITextFieldDelegate>
@property(nonatomic, strong)InputView* keyInputView;
@property(nonatomic, strong)InputView* valueInputView;
@property(nonatomic, strong)UIButton* listButton;

@property(nonatomic, strong)UISegmentedControl* reminderControl;

@property(nonatomic, strong)NSArray* reminderValues;

@property(nonatomic, strong)NSLayoutConstraint* listButtonBottomConstraint;
@end

@implementation EntryViewController

- (NSArray *)reminderValues
{
    if (!_reminderValues) {
        _reminderValues = @[EntryRepetitionNever,
                            EntryRepetitionSecond,
                            EntryRepetitionMinute,
                            EntryRepetitionHour,
                            EntryRepetitionDay,
                            EntryRepetitionWeek];
    }
    return _reminderValues;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.layer.cornerRadius = 5;
    self.view.backgroundColor = [UIColor whiteColor];
    
    InputView* (^addInputView)(NSString* placeholder, UIReturnKeyType keyType) = ^InputView*(NSString* placeholder, UIReturnKeyType keyType) {
        InputView* view = InputView.new;
        view.placeholder = placeholder;
        view.returnKeyType = keyType;      
        view.delegate = self;
        [self.view addSubview:view];
        return view;    
    };
    self.keyInputView = addInputView(@"Key", UIReturnKeyNext);
    self.valueInputView = addInputView(@"Value", UIReturnKeyDone);
    
    self.reminderControl = [[UISegmentedControl alloc] initWithItems:self.reminderValues];    
    self.reminderControl.selectedSegmentIndex = [self.reminderValues indexOfObject:EntryRepetitionNever];
    [self.view addSubview:self.reminderControl];
    
    self.listButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.listButton setTitle:@"0 entries" forState:UIControlStateNormal];
    [self.listButton sizeToFit];
    [self.listButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [self.listButton addTarget:self action:@selector(showList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.listButton];
    
    // layout
    NSDictionary* views = NSDictionaryOfVariableBindings(_keyInputView, _valueInputView, _reminderControl);
    for (UIView* view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[view]-(10)-|"
                                                                          options:0
                                                                          metrics:nil 
                                                                            views:NSDictionaryOfVariableBindings(view)]];
        
    }
    NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(40)-[_reminderControl]-[_keyInputView]-[_valueInputView]"
                                                                   options:NSLayoutFormatAlignAllCenterX // |-60
                                                                   metrics:nil 
                                                                     views:views];
    [self.view addConstraints:constraints];
    
    self.listButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.listButton
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight 
                                                         multiplier:1
                                                           constant:-10]];
    
    self.listButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.listButton
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeBottom 
                                                                  multiplier:1
                                                                    constant:-10];
    [self.view addConstraint:self.listButtonBottomConstraint];
    
    
    // keyboard
    [self registerForKeyboardNotifications];
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture)];
    [self.view addGestureRecognizer:gesture];
    self.reminderControl.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.eventHandler prepareNewEntry];
}

- (void)handleGesture
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark - AddEntryView

- (void)updateCount:(NSUInteger)count
{
    NSString* title = [NSString stringWithFormat:@"%ld entries", count];
    [self.listButton setTitle:title forState:UIControlStateNormal];
}

- (void)setKey:(NSString*)key
{
    self.keyInputView.text = key;
}

- (void)setValue:(NSString*)value
{
    self.valueInputView.text = value;
}

- (void)selectReminderValueAtIndex:(NSUInteger)index
{
    self.reminderControl.selectedSegmentIndex = index;
}

- (NSString*)selectedReminderValue
{
    return self.reminderValues[self.reminderControl.selectedSegmentIndex];
}

- (void)focusOnKey
{
    [self.keyInputView becomeFirstResponder];
}

- (void)focusOnValue
{
    [self.valueInputView becomeFirstResponder];
}

- (void)showSuccess
{
    self.view.tintColor = [UIColor blueColor];
    self.view.window.tintColor = [UIColor blueColor];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"🍻Entry saved!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAlertDismissTimeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        alertView.message = @"Dismissing...";
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    });
}

- (void)showError:(NSError *)error
{
    self.view.tintColor = [UIColor redColor];
    self.view.window.tintColor = [UIColor redColor];
    [[[UIAlertView alloc] initWithTitle:@"🔥 Error"
                                message:error.localizedDescription
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.keyInputView) {
        [self.eventHandler updateKey:textField.text];
    }
    else if (textField == self.valueInputView) {
        [self.eventHandler updateValue:textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];// call textFieldDidEndEditing
    if (textField == self.valueInputView) {
        [self.eventHandler save];
    }
    
    return YES;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView.title hasPrefix:@"🔥"]) {
        [self.valueInputView becomeFirstResponder];
    }else{
        [self.eventHandler scheduleNotification];
        [self.eventHandler prepareNewEntry];
    }
}

#pragma mark - Keyboard

static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve)
{
    return (UIViewAnimationOptions)curve << 16;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    [self animateControls:[notification userInfo] up:YES];
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    [self animateControls:[notification userInfo] up:NO];
}

- (void)animateControls:(NSDictionary*)userInfo up:(BOOL)up
{
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGRect kbFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbFrame = [self.view convertRect:kbFrame fromView:nil];
    self.listButtonBottomConstraint.constant = up ? -10 : (- kbFrame.size.height);
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:duration
                          delay:0
                        options:animationOptionsWithCurve(animationCurve) | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.listButtonBottomConstraint.constant = up ? (- kbFrame.size.height) : -10;
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished){
                     }];
}

#pragma mark - Actions

- (void)showList:(id)sender
{
    [self.eventHandler presentListInterface];
}
@end