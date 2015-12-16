//
//  ShowEntryInteractorTests.m
//  bam
//
//  Created by François Benaiteau on 16/12/15.
//  Copyright © 2015 François Benaiteau. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ShowEntryInteractor.h"

#import "EntryDataStore.h"
#import "CoreDataStack.h"
#import "EntryNotifier.h"

@interface ShowEntryInteractorTests : XCTestCase
@property(nonatomic, strong)ShowEntryInteractor* sut;
@end

@implementation ShowEntryInteractorTests

- (void)setUp {
    [super setUp];
    EntryNotifier* notifier = nil;//[[EntryNotifier alloc] init];
    CoreDataStack* stack = [[CoreDataStack alloc] initWithFilename:nil options:CoreDataStackInMemoryOption];
    EntryDataStore* dataStore = [[EntryDataStore alloc] initWithCoreDataStack:stack];
    self.sut = [[ShowEntryInteractor alloc] initWithDataManager:dataStore notifier:notifier];
}

- (void)tearDown {
    self.sut = nil;
    [super tearDown];
}

- (void)test_handleActionWithIdentifier_forLocalNotification_GivenNotification_DoesNotCrash {
    UILocalNotification* notif = [UILocalNotification new];
    notif.userInfo = @{"key":}
    self.sut
    
}

@end
