//
//  NotificationHelper.m
//  bam
//
//  Created by François Benaiteau on 28/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import "NotificationHelper.h"

// move to util class
NSString * const EntryRepetitionNever = @"never";
NSString * const EntryRepetitionSecond = @"second";
NSString * const EntryRepetitionMinute = @"minute";
NSString * const EntryRepetitionHour = @"hourly";
NSString * const EntryRepetitionDay = @"daily";
NSString * const EntryRepetitionWeek = @"weekly";

@implementation NotificationHelper

+ (NSNumber*)valueForRepeatInterval:(NSCalendarUnit)unit
{

}

+ (NSNumber*)nextRepeatIntervalForUnit:(NSCalendarUnit)unit
{
    switch (unit) {
        case NSSecondCalendarUnit:
            return @(NSMinuteCalendarUnit);
            break;
        case NSMinuteCalendarUnit:
            return @(NSHourCalendarUnit);
            break;
        case NSHourCalendarUnit:
            return @(NSDayCalendarUnit);
            break;
        case NSDayCalendarUnit:
            return @(NSMinuteCalendarUnit);
            break;
        case NSWeekCalendarUnit:
            return nil;
            break;
            
        default:
            break;
    }
    return nil;
}

+ (NSUInteger)valueForReminderName:(NSString*)name
{
    if ([name isEqualToString:EntryRepetitionSecond]) {
        return 30;
    }else if ([name isEqualToString:EntryRepetitionMinute]) {
        return 5 * 60;
    }else if ([name isEqualToString:EntryRepetitionHour]) {
        return 60 * 60;
    }else if ([name isEqualToString:EntryRepetitionDay]) {
        return 24 * 60 * 60;
    }else if ([name isEqualToString:EntryRepetitionWeek]) {
        return 7 * 24 * 60 * 60;
    }else{
        return 0;// EntryRepetitionNever and .*
    }
}

+ (NSCalendarUnit)repeatIntervalForReminderName:(NSString*)name
{
    if ([name isEqualToString:EntryRepetitionSecond]) {
        return NSSecondCalendarUnit;
    }else if ([name isEqualToString:EntryRepetitionMinute]) {
        return NSMinuteCalendarUnit;
    }else if ([name isEqualToString:EntryRepetitionHour]) {
        return NSHourCalendarUnit;
    }else if ([name isEqualToString:EntryRepetitionDay]) {
        return NSDayCalendarUnit;
    }else if ([name isEqualToString:EntryRepetitionWeek]) {
        return NSWeekCalendarUnit;
    }else{
        return 0;// EntryRepetitionNever and .*
    }
}

@end
