//
//  ShowEntryPresenter.h
//  bam
//
//  Created by François Benaiteau on 28/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ShowEntryEventHandler <NSObject>
- (void)processNotification:(UILocalNotification*)notification;
@end

@class ShowEntryWireframe;

@interface ShowEntryPresenter : NSObject
@property(nonatomic, strong)ShowEntryWireframe* wireframe;
@property(nonatomic, strong)UIViewController* view;
@end
