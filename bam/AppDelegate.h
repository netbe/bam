//
//  AppDelegate.h
//  bam
//
//  Created by François Benaiteau on 11/04/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDependencies;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) AppDependencies* appDependencies;
@property (nonatomic, strong)UIWindow* window;
@end
