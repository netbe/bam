//
//  Entry+BAMAdditions.m
//  bam
//
//  Created by François Benaiteau on 19/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "Entry+BAMAdditions.h"

@implementation Entry (BAMAdditions)

+ (NSArray*)fetchEntriesInContext:(NSManagedObjectContext*)context
{
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Entry"];
    NSError* error = nil;
    NSArray* results = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@ in %s", error, __PRETTY_FUNCTION__);
    }
    return results;
}

+ (NSFetchRequest*)fetchRequest;
{
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Entry"];
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"key" ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    return request;
}

- (PlainEntry*)plainEntry
{
    PlainEntry * plainEntry = [[PlainEntry alloc] init];
    plainEntry.key = self.key;
    plainEntry.value = self.value;
    plainEntry.level = [PlainLevel levelFromPayload:self.level];
    return plainEntry;
}
@end
