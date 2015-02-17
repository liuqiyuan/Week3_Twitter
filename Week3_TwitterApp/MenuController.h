//
//  MenuController.h
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/16/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

extern NSString * const ClickProfileButtonNotification;
extern NSString * const ClickTimelineButtonNotification;
extern NSString * const ClickMentionsButtonNotification;

@interface MenuController : UIViewController

@property (nonatomic, strong) User *user;

@end
