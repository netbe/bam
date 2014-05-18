//
//  EntryView.m
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "EntryView.h"

@implementation EntryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
        
        NSDictionary* views = NSDictionaryOfVariableBindings(_keyInputView, _valueInputView);
        for (UIView* view in views.allValues) {
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                         options:0
                                                                         metrics:nil 
                                                                           views:NSDictionaryOfVariableBindings(view)]];
            
        }
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_keyInputView(40)]-[_valueInputView(40)]"
                                                                       options:NSLayoutFormatAlignAllCenterX
                                                                       metrics:nil 
                                                                         views:views];
        [self addConstraints:constraints];
        
        self.keyInputView.placeholder = @"Key";     
        self.valueInputView.placeholder = @"Value";
        
    }
    return self;
}

- (BOOL)becomeFirstResponder
{
    
    return [self.keyInputView becomeFirstResponder];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
