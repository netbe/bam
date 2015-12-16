//
//  CoreDataStack.m
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import "CoreDataStack.h"

static NSString* const kModelName = @"Model";

@interface CoreDataStack ()

@property(nonatomic, copy, readwrite)NSString* filename;
@property(nonatomic, assign, readwrite)CoreDataStackOptions options;

@end

@implementation CoreDataStack

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.filename = [[[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] stringByAppendingPathExtension:@"sqlite"];
        self.options = CoreDataStackNoneOption;
    }
    return self;
}

- (instancetype)initWithFilename:(NSString*)filename options:(CoreDataStackOptions)options;
{
    self = [super init];
    if (self) {
        self.filename = filename;
        self.options = options;
    }
    return self;
}

- (BOOL)setup:(NSError**)pError
{
    NSError *localError = nil;
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kModelName withExtension:@"momd"];
    NSAssert(modelURL, @"file %@.xcdatamodeld does not exist", kModelName);
    self.model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
    NSString* storeType = nil;
    NSURL *storeURL = nil;
    // add Stores
    if(self.options & CoreDataStackInMemoryOption) {
        storeType = NSSQLiteStoreType;
        NSURL *storeURL = [NSURL fileURLWithPath:[[self.class applicationDocumentsDirectory] stringByAppendingPathComponent:self.filename]];
        
        if (self.options & CoreDataStackForceRemoveFileOption && [[NSFileManager defaultManager] fileExistsAtPath:storeURL.absoluteString])  {
            // TODO: remove other aliases -shm -wal
            if (![[NSFileManager defaultManager] removeItemAtURL:storeURL error:&localError]) {
                NSLog(@"error setup CoreData %@", localError);
                if (pError) {
                    *pError = localError;
                }
                return NO;
            }
            
        }
    }else {
        storeType = NSInMemoryStoreType;
    }
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:storeType
                                                       configuration:nil
                                                                 URL:storeURL
                                                             options:@{NSMigratePersistentStoresAutomaticallyOption: @(YES),NSInferMappingModelAutomaticallyOption: @(YES)}
                                                               error:&localError])
    {
        NSLog(@"error setup CoreData %@", localError);
        if (pError) {
            *pError = localError;
        }
        return NO;
    }
    return YES;
}

- (NSManagedObjectContext *)mainContext
{
    if (!_mainContext) {
        _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _mainContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _mainContext;
}

+ (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
