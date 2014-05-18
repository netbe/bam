//
//  ServiceManager.h
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "CoreDataStack.h"
#import "Entry.h"

@interface ServiceManager : NSObject
@property(nonatomic, strong)CoreDataStack* coreDataStack;

- (void)setupCoreData;
- (Entry*)createEntryWithKey:(NSString*)key value:(NSString*)value;
@end
