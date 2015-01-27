//
//  PlainEntry.m
//  bam
//
//  Created by François Benaiteau on 29/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "PlainEntry.h"

@implementation PlainEntry
+ (instancetype)entryWithKey:(NSString*)key value:(NSString*)value
{
    PlainEntry* entry = [[PlainEntry alloc] init];
    entry.key = key;
    entry.value = value;
    return entry;
}

- (NSDictionary*)dictionaryRepresentation
{
    return @{@"key": self.key,
             @"value": self.value,
             @"type": @(self.type)};
}

- (NSString*)definitionTextForNotification
{
    return [NSString stringWithFormat:@"'%@' = '%@'", self.key, self.value];
}
@end
