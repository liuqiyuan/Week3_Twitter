//
//  Tweet.m
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/8/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.id = (long)dictionary[@"id"];
        self.text = dictionary[@"text"];
        self.user = [[User alloc]initWithDictionary:dictionary[@"user"]];
        NSString *createdDateStr = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        
        self.createdDate = [formatter dateFromString:createdDateStr];
        self.numFavoriates = [dictionary[@"favorite_count"] integerValue];
        self.numRetweets = [dictionary[@"retweet_count"] integerValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
    }

    return self;
}

+ (NSArray *)tweetsWithArray: (NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        [tweets addObject:[[Tweet alloc]initWithDictionary:dict]];
    }
    
    return tweets;
}


@end
