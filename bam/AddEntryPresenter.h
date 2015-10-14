//
//  AddEntryPresenter.h
//  bam
//
//  Created by François Benaiteau on 01/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddEntryInteractor;
@class ListEntryWireframe;
@class EntryNotifier;
#import "EntryIO.h"

@interface AddEntryPresenter : NSObject<AddEntryEventHandler>

@property(nonatomic, copy)NSString* key;
@property(nonatomic, copy)NSString* value;

@property(nonatomic, strong)EntryNotifier* notifier;

@property(nonatomic, strong)AddEntryInteractor* interactor;
@property(nonatomic, strong)id<AddEntryView> view;
@property(nonatomic, strong)ListEntryWireframe* listWireframe;

@end
