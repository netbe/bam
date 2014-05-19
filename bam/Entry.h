//
//  Entry.h
//  bam
//
//  Created by François Benaiteau on 19/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entry : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSNumber * learned;
@property (nonatomic, retain) NSNumber * repeatInterval;
@property (nonatomic, retain) NSString * value;

@end
