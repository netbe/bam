//
//  EntryView.m
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "EntryView.h"

NSString * const EntryRepetitionNever = @"never";
NSString * const EntryRepetitionSecond = @"second";
NSString * const EntryRepetitionMinute = @"minute";
NSString * const EntryRepetitionHour = @"hourly";
NSString * const EntryRepetitionDay = @"daily";
NSString * const EntryRepetitionWeek = @"weekly";

@implementation EntryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;

        self.backgroundColor = [UIColor whiteColor];
        self.keyInputView = ({
            InputView* view = InputView.new;
            [self addSubview:view];
            view;
        });
        
        self.valueInputView = ({
            InputView* view = InputView.new;
            [self addSubview:view];
            view;
        });
        
        self.reminderControl = [[UISegmentedControl alloc] initWithItems:self.reminderValues];
        [self addSubview:self.reminderControl];

        self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.saveButton setTitle:@"SAVE" forState:UIControlStateNormal];
        [self.saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.saveButton];
        
        NSDictionary* views = NSDictionaryOfVariableBindings(_keyInputView, _valueInputView, _reminderControl, _saveButton);
        for (UIView* view in views.allValues) {
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(5)-[view]-(5)-|"
                                                                         options:0
                                                                         metrics:nil 
                                                                           views:NSDictionaryOfVariableBindings(view)]];
            
        }
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_keyInputView]-[_valueInputView]-(40)-[_reminderControl]"
                                                                       options:NSLayoutFormatAlignAllCenterX
                                                                       metrics:nil 
                                                                         views:views];
        [self addConstraints:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_saveButton(40)]-|"
                                                              options:NSLayoutFormatAlignAllCenterX
                                                              metrics:nil
                                                                views:views];
        [self addConstraints:constraints];
        
        [self applyDefaultValues];
    }
    return self;
}

- (BOOL)becomeFirstResponder
{
    return [self.keyInputView becomeFirstResponder];
}
- (BOOL)resignFirstResponder
{
    return [self.keyInputView resignFirstResponder] && [self.valueInputView resignFirstResponder];;
}
- (void)applyDefaultValues
{
    self.keyInputView.placeholder = @"Key";
    self.valueInputView.placeholder = @"Value";
    self.reminderControl.selectedSegmentIndex = 0;
    self.keyInputView.returnKeyType = UIReturnKeyNext;
    self.valueInputView.returnKeyType = UIReturnKeyDone;
}

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
@end
