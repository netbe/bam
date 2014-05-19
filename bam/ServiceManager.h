//
//  ServiceManager.h
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "CoreDataStack.h"
#import "Entry+BAMAdditions.h"
#import "EntryNotifier.h"

@interface ServiceManager : NSObject
@property(nonatomic, strong)CoreDataStack* coreDataStack;
@property(nonatomic, strong)EntryNotifier* notifier;
- (void)setupCoreData;
- (Entry*)createEntryWithKey:(NSString*)key value:(NSString*)value repeatInterval:(NSCalendarUnit)repeatInterval;
- (void)scheduleEntryNotifications;
@end
