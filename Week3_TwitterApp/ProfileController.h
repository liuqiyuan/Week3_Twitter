//
//  ProfileController.h
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/16/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TweetCell.h"

@interface ProfileController : UIViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) TweetCell *prototypeCell;


@end
