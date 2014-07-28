//
//  ListEntryPresenter.h
//  bam
//
//  Created by François Benaiteau on 23/07/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ListEventHandler <NSObject>
- (void)addGestureToView:(UIView*)view;
- (void)dismissList;
@end

@protocol ListView <NSObject>
@end

@class ListEntryWireframe;
@class ListInteractiveTransition;

@interface ListEntryPresenter : NSObject<ListEventHandler>
@property(nonatomic, strong)ListInteractiveTransition* interactiveTransition;
@property(nonatomic, strong)ListEntryWireframe* listWireframe;
@property(nonatomic, weak)id<ListView> listView;
@end
