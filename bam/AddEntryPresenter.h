//
//  AddEntryPresenter.h
//  bam
//
//  Created by François Benaiteau on 01/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const EntryRepetitionNever;
extern NSString * const EntryRepetitionSecond;
extern NSString * const EntryRepetitionMinute;
extern NSString * const EntryRepetitionHour;
extern NSString * const EntryRepetitionDay;
extern NSString * const EntryRepetitionWeek;

@class AddEntryInteractor;
@class ListEntryWireframe;
@protocol AddEntryEventHandler <NSObject>
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

@interface AddEntryPresenter : NSObject<AddEntryEventHandler>

@property(nonatomic, copy)NSString* key;
@property(nonatomic, copy)NSString* value;
@property(nonatomic, strong)NSNumber* repeatInterval;

@property(nonatomic, strong)AddEntryInteractor* interactor;
@property(nonatomic, strong)id<AddEntryView> view;
@property(nonatomic, strong)ListEntryWireframe* listWireframe;

@end
