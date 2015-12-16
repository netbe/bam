//
//  Entry.h
//  bam
//
//  Created by François Benaiteau on 30/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Entry : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSNumber * learned;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) id level;

@end
