//
//  EditEntryInteractor.h
//  bam
//
//  Created by François Benaiteau on 01/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EntryDataStore;

@interface EditEntryInteractor : NSObject
-(id)initWithDataManager:(EntryDataStore*)dataStore;
-(void)editEntryWithKey:(NSString*)key updatedKey:(NSString*)key value:(NSString*)value period:(NSUInteger)period;

-(void)editEntryWithKey:(NSString*)key updatedKey:(NSString*)key value:(NSString*)value period:(NSUInteger)period;

@end
