//
//  EntryView.h
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputView.h"

extern NSString * const EntryRepetitionNever;
extern NSString * const EntryRepetitionSecond;
extern NSString * const EntryRepetitionMinute;
extern NSString * const EntryRepetitionHour;
extern NSString * const EntryRepetitionDay;
extern NSString * const EntryRepetitionWeek;

@interface EntryView : UIView
@property(nonatomic, strong)InputView* keyInputView;
@property(nonatomic, strong)InputView* valueInputView;
@property(nonatomic, strong)UIButton* saveButton;
@property(nonatomic, strong)UISegmentedControl* reminderControl;
@property(nonatomic, strong)NSArray* reminderValues;
@end
