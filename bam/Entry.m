//
//  Entry.m
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "Entry.h"


@implementation Entry

@dynamic key;
@dynamic value;

- (NSString*)formattedString
{
    return [NSString stringWithFormat:@"%@ : %@", self.key, self.value];
}
@end
