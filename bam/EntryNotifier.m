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
//        didReceiveLocalNotification
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification
//                                                   object:nil];

    }
    return self;
}

- (void)scheduleNotificationWithText:(NSString*)text intervalInSeconds:(NSTimeInterval)seconds repeatInterval:(NSCalendarUnit)repeatInterval
{
    NSLog(@"Schedule %@", text);
    UILocalNotification* notification = [[UILocalNotification alloc] init];
    notification.alertBody = text;
    notification.alertAction = @"Check Value";
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:seconds];
    notification.repeatInterval = repeatInterval;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}


@end
