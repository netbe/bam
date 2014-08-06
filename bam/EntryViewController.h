//
//  EntryViewController.h
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddEntryPresenter.h"

@interface EntryViewController : UIViewController<AddEntryView>
@property(nonatomic, weak)id<AddEntryEventHandler> eventHandler;

@end
