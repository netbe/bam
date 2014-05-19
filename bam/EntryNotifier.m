//
//  EntryNotifier.m
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "EntryNotifier.h"

@implementation EntryNotifier

- (id)init
{
    self = [super init];
    if (self) {
        self.defaultTime = 5;
    }
    return self;
}

- (void)scheduleNotificationWithText:(NSString*)text repeatInterval:(NSCalendarUnit)repeatInterval
{
    NSLog(@"Schedule %@", text);
    UILocalNotification* notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date];
    notification.alertBody = text;
    notification.alertAction = NO;
    notification.repeatInterval = repeatInterval;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}
@end
