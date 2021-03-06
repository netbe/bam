//
//  Entry+BAMAdditions.h
//  bam
//
//  Created by François Benaiteau on 19/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "Entry.h"

#import "PlainEntry.h"
#import "PlainLevel.h"

@interface Entry (BAMAdditions)
+ (NSArray*)fetchEntriesInContext:(NSManagedObjectContext*)context;
+ (NSFetchRequest*)fetchRequest;
- (PlainEntry*)plainEntry;
@end
