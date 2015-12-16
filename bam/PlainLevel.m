//
//  PlainLevel.m
//  bam
//
//  Created by François Benaiteau on 29/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import "PlainLevel.h"

@implementation PlainLevel

- (NSDictionary*)dictionaryRepresentation
{
    return @{@"difficulty": @(self.difficulty),
             @"timeInterval": @(self.timeInterval),
             @"repeatTimeInterval": @(self.repeatTimeInterval),
             @"type": @(self.type)};
}

- (instancetype)nextLevel
{
    PlainLevel* nextLevel = nil;
    NSString* selectorString = [NSString stringWithFormat:@"level%lu", self.difficulty + 1];
    SEL selector = NSSelectorFromString(selectorString);
    NSMethodSignature *signature = [self.class methodSignatureForSelector:selector];
    if (signature) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.selector = selector;
        invocation.target = [self class];
        [invocation invoke];
        [invocation getReturnValue:&nextLevel];
    }
    return nextLevel;
}

+ (instancetype)levelFromPayload:(NSDictionary*)payload
{
    if(payload) {
        PlainLevel* level = [[PlainLevel alloc] init];
        level.difficulty = [payload[@"difficulty"] unsignedIntegerValue];
        level.timeInterval = [payload[@"timeInterval"] doubleValue];
        level.repeatTimeInterval = [payload[@"repeatTimeInterval"] unsignedIntegerValue];
        level.type = [(NSNumber*)payload[@"type"] unsignedIntegerValue];
        return level;
    }
    return nil;
}

+ (instancetype)level1
{
    PlainLevel* level = [PlainLevel new];
    level.difficulty = 1;
    level.type = EntryTypeDefinition;
    level.repeatTimeInterval = NSCalendarUnitMinute;
    level.timeInterval = 60;
    return level;
}

+ (instancetype)level2
{
    PlainLevel* level = [PlainLevel new];
    level.difficulty = 2;
    level.type = EntryTypeGuess;
    level.repeatTimeInterval = NSCalendarUnitHour;
    level.timeInterval = 60 * 60;
    return level;
}

+ (instancetype)level3
{
    PlainLevel* level = [PlainLevel new];
    level.difficulty = 3;
    level.type = EntryTypeReverseGuess;
    level.repeatTimeInterval = NSCalendarUnitDay;
    level.timeInterval = 60 * 60 * 24;
    return level;
}

+ (instancetype)level4
{
    PlainLevel* level = [PlainLevel new];
    level.difficulty = 4;
    level.type = EntryTypeGuess;
    level.repeatTimeInterval = NSCalendarUnitWeekday;
    level.timeInterval = 60 * 60 * 24 * 7;
    return level;
}

+ (instancetype)level5
{
    PlainLevel* level = [PlainLevel new];
    level.difficulty = 5;
    level.type = EntryTypeReverseGuess;
    level.repeatTimeInterval = NSCalendarUnitMonth;
    level.timeInterval = 60 * 60 * 24 * 7 * 30;
    return level;
}

@end
