//
//  PlainEntry.h
//  bam
//
//  Created by François Benaiteau on 29/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, EntryType){
    EntryTypeDefinition,
    EntryTypeGuess,
    EntryTypeReverseGuess
};

@interface PlainEntry : NSObject
@property (nonatomic, strong) NSString * key;
@property (nonatomic, strong) NSString * value;
@property (nonatomic, assign) EntryType type;

+ (instancetype)entryFromPayload:(NSDictionary*)payload;
+ (instancetype)entryWithKey:(NSString*)key value:(NSString*)value;
- (NSDictionary*)dictionaryRepresentation;
- (NSString*)definitionTextForNotification;
@end
