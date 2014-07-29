//
//  ListEntryPresenter.h
//  bam
//
//  Created by François Benaiteau on 23/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlainEntry.h"

@protocol ListEventHandler <NSObject>
- (void)addGestureToView:(UIView*)view;
- (void)dismissList;
- (void)updateView;

@end

@protocol ListView <NSObject>
- (void)displayAddEntryButton:(BOOL)display;
- (void)setEntries:(NSArray*)entries;
@end

@class ListEntryWireframe;
@class ListEntryInteractor;
@class ListInteractiveTransition;

@interface ListEntryPresenter : NSObject<ListEventHandler>
@property(nonatomic, strong)ListInteractiveTransition* interactiveTransition;
@property(nonatomic, strong)ListEntryWireframe* listWireframe;
@property(nonatomic, weak)id<ListView> listView;
@property(nonatomic, strong)ListEntryInteractor* listInteractor;
@end
