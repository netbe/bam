//
//  NotificationHelper.h
//  bam
//
//  Created by François Benaiteau on 28/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const EntryRepetitionNever;
extern NSString * const EntryRepetitionSecond;
extern NSString * const EntryRepetitionMinute;
extern NSString * const EntryRepetitionHour;
extern NSString * const EntryRepetitionDay;
extern NSString * const EntryRepetitionWeek;

@interface NotificationHelper : NSObject
+ (NSUInteger)valueForReminderName:(NSString*)name;
+ (NSCalendarUnit)repeatIntervalForReminderName:(NSString*)name;
+ (NSNumber*)nextRepeatIntervalForUnit:(NSCalendarUnit)unit;
@end
