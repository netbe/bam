//
//  CoreDataStack.h
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

typedef NS_OPTIONS(NSUInteger, CoreDataStackOptions) {
    CoreDataStackNoneOption = 1 << 0,
    CoreDataStackForceRemoveFileOption = 1 << 1,
    CoreDataStackNoBackupOption = 1 << 2,
    CoreDataStackInMemoryOption = 1 << 3
};

@interface CoreDataStack : NSObject

@property(nonatomic, copy, readonly)NSString* filename;
@property(nonatomic, assign, readonly)CoreDataStackOptions options;

@property(nonatomic, strong)NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property(nonatomic, strong)NSManagedObjectContext* mainContext;
@property(nonatomic, strong)NSManagedObjectModel* model;

- (instancetype)initWithFilename:(NSString*)filename options:(CoreDataStackOptions)options;
- (BOOL)setup:(NSError**)error;
@end
