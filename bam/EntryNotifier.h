//
//  EntryNotifier.h
//  bam
//
//  Created by François Benaiteau on 18/05/14.
//  Copyright (c) 2014 François Benaiteau. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const EntryNotifierNotificationAgreement;
extern NSString *const EntryNotifierNotificationAgreementDeniedKey;
extern NSString *const EntryNotifierNotificationCategoryDefinition;
extern NSString *const EntryNotifierNotificationCategoryDefinitionAction;

@interface EntryNotifier : NSObject
@property(nonatomic, assign)NSUInteger defaultTime;

- (void)scheduleNotificationWithText:(NSString*)text 
                            category:(NSString*)category
                   intervalInSeconds:(NSTimeInterval)seconds
                      repeatInterval:(NSCalendarUnit)repeatInterval 
                            userInfo:(NSDictionary*)userInfo;
- (BOOL)shouldAskNotificationPermissions;
- (void)authorizeNotifications:(BOOL)authorized;
- (void)showAuthorizationDialog;
@end
