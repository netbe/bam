//
//  EditEntryPresenter.h
//  bam
//
//  Created by François Benaiteau on 30/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntryIO.h"
@class EditEntryInteractor;

@interface EditEntryPresenter : NSObject<AddEntryEventHandler>
@property(nonatomic, strong)id<AddEntryView> view;
@property(nonatomic, strong)EditEntryInteractor* interactor;
@end
