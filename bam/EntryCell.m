//
//  EntryCell.m
//  bam
//
//  Created by François Benaiteau on 27/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "EntryCell.h"

@implementation EntryCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.cornerRadius = 5;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.keyLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.keyLabel];
        
        self.valueLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.valueLabel];
        
        NSDictionary* views = NSDictionaryOfVariableBindings(_valueLabel, _keyLabel);
        for (UIView* view in views.allValues) {
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(5)-[view]-(5)-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:NSDictionaryOfVariableBindings(view)]];
            
        }
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_keyLabel]-[_valueLabel]-|"
                                                                       options:NSLayoutFormatAlignAllCenterX
                                                                       metrics:nil
                                                                         views:views];
        [self.contentView addConstraints:constraints];

    }
    return self;
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
