//
//  AddEntryInteractor.h
//  bam
//
//  Created by François Benaiteau on 30/06/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EntryDataStore;

/**
 * @brief Interactor to add an Entry
 */
@interface AddEntryInteractor : NSObject
@property(nonatomic, strong, readonly)EntryDataStore* dataStore;

-(id)initWithDataManager:(EntryDataStore*)dataStore;
-(BOOL)addEntryWithKey:(NSString*)key value:(NSString*)value level:(id)level error:(NSError**)pError;
-(NSUInteger)countEntries;
@end
