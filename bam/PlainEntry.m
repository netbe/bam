//
//  PlainEntry.m
//  bam
//
//  Created by François Benaiteau on 29/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "PlainEntry.h"

#import "PlainLevel.h"

@implementation PlainEntry

+ (instancetype)entryFromPayload:(NSDictionary*)payload
{
    PlainEntry* entry = [[PlainEntry alloc] init];
    entry.key = payload[@"key"];
    entry.value = payload[@"value"];
    entry.level = [PlainLevel levelFromPayload:payload[@"level"]];
    return entry;
}

+ (instancetype)entryWithKey:(NSString*)key value:(NSString*)value
{
    PlainEntry* entry = [[PlainEntry alloc] init];
    entry.key = key;
    entry.value = value;
    entry.level = [PlainLevel level1];
    return entry;
}

- (NSDictionary*)dictionaryRepresentation
{
    return @{@"key": self.key,
             @"value": self.value,
             @"level": self.level.dictionaryRepresentation};
}


- (NSString*)textForNotification
{
    if (self.level.difficulty == 1) {
        return [self definitionTextForNotification];
    }else{
        NSAssert(false, @"not implemented yet");
        return nil;
    }

}
- (NSString*)definitionTextForNotification
{
    return [NSString stringWithFormat:@"'%@' = '%@'", self.key, self.value];
}
@end
