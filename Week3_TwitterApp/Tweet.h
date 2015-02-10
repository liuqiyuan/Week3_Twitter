//
//  Tweet.h
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/8/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject


@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdDate;
@property (nonatomic, strong) User *user;
@property (nonatomic, assign) NSInteger numRetweets;
@property (nonatomic, assign) NSInteger numFavoriates;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL retweeted;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray: (NSArray *)array;


@end
