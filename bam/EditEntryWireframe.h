//
//  EditEntryWireframe.h
//  bam
//
//  Created by François Benaiteau on 30/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EditEntryInteractor;
@class EditEntryPresenter;
@class EntryDataStore;

@interface EditEntryWireframe : NSObject
@property(nonatomic, strong)EditEntryInteractor* interactor;
@property(nonatomic, strong)EditEntryPresenter* presenter;

-(id)initWithDataManager:(EntryDataStore*)dataStore;
-(void)presentEditViewForEntryWithKey:(NSString*)key;
@end
