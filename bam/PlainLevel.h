//
//  PlainLevel.h
//  bam
//
//  Created by François Benaiteau on 29/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, EntryType){
    EntryTypeDefinition,
    EntryTypeGuess,
    EntryTypeReverseGuess
};

@interface PlainLevel : NSObject
@property (nonatomic, assign) NSUInteger difficulty;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, assign) NSCalendarUnit repeatTimeInterval;
@property (nonatomic, assign) EntryType type;

- (NSDictionary*)dictionaryRepresentation;

- (instancetype)nextLevel;

+ (instancetype)levelFromPayload:(NSDictionary*)payload;
+ (instancetype)level1;
+ (instancetype)level2;
+ (instancetype)level3;
+ (instancetype)level4;
+ (instancetype)level5;
@end
