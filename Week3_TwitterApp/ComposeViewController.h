//
//  ComposeViewController.h
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/9/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

extern NSString * const UserDidComposeNotification;

@interface ComposeViewController : UIViewController

@property (nonatomic, strong) User *user;

- (id)initWithUser: (User *) user;

@end
