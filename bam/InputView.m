//
//  InputView.m
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "InputView.h"

static CGFloat const kMargin = 5;

@implementation InputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.borderStyle = UITextBorderStyleNone;
        // Initialization code
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.cornerRadius = 5;
        self.tintColor = [UIColor redColor];
        
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return self;
}

- (void)setColor:(UIColor*)color
{
    self.layer.borderColor = color.CGColor;
    self.tintColor = color;
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, 60);
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + kMargin, bounds.origin.y, bounds.size.width - kMargin, bounds.size.height);
}
//
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (CGRect)borderRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

//- (CGRect)caretRectForPosition:(UITextPosition *)position
//{
//    return CGRectMake(self.bounds.origin.x + kMargin, self.bounds.origin.y, 1, self.bounds.size.height);
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
