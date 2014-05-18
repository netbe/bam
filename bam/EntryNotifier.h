//
//  EntryNotifier.h
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntryNotifier : NSObject
@property(nonatomic, assign)NSUInteger defaultTime;
- (void)scheduleNotificationWithText:(NSString*)text;
@end
