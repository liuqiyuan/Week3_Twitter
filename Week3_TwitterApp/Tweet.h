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


@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdDate;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *numRetweets;
@property (nonatomic, strong) NSString *numFavoriates;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray: (NSArray *)array;


@end
