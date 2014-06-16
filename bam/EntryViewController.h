//
//  EntryViewController.h
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ServiceManager;


@interface EntryViewController : UIViewController
@property(nonatomic, strong)ServiceManager* serviceManager;
@property(nonatomic, copy)NSString* key;
@property(nonatomic, copy)NSString* value;
@property(nonatomic, strong)NSNumber* repeatInterval;
@end
