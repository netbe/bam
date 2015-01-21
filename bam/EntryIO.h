//
//  EntryIO.h
//  bam
//
//  Created by François Benaiteau on 30/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddEntryEventHandler <NSObject>
- (void)scheduleNotification;
- (void)prepareNewEntry;
- (void)updateKey:(NSString*)key;
- (void)updateValue:(NSString*)value;
- (void)save;
- (void)presentListInterface;
@end

@protocol AddEntryView <NSObject>
- (NSString*)selectedReminderValue;

- (void)setKey:(NSString*)key;
- (void)setValue:(NSString*)value;

- (void)selectReminderValueAtIndex:(NSUInteger)index;

- (void)focusOnKey;
- (void)focusOnValue;

- (void)updateCount:(NSUInteger)count;

- (void)showSuccess;
- (void)showError:(NSError*)error;
@end
