//
//  ShowEntryWireframe.h
//  bam
//
//  Created by François Benaiteau on 28/01/15.
//  Copyright (c) 2015 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowEntryWireframe : NSObject
@property(nonatomic, strong)ShowEntryInteractor* interactor;
- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler;

@end
