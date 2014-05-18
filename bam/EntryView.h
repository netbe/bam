//
//  EntryView.h
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"

@interface EntryView : UIView
@property(nonatomic, strong)InputView* keyInputView;
@property(nonatomic, strong)InputView* valueInputView;

@end
