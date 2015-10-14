//
//  PlainEntry.h
//  bam
//
//  Created by François Benaiteau on 29/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PlainLevel;

@interface PlainEntry : NSObject
@property (nonatomic, strong) NSString* key;
@property (nonatomic, strong) NSString* value;
@property (nonatomic, strong) PlainLevel* level;

+ (instancetype)entryFromPayload:(NSDictionary*)payload;
+ (instancetype)entryWithKey:(NSString*)key value:(NSString*)value;
- (NSDictionary*)dictionaryRepresentation;
- (NSString*)textForNotification;
@end
