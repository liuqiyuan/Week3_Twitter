//
//  TwitterClient.h
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/8/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)updateStatusWithParams:(NSDictionary *)params completion:(void (^)(NSDictionary *tweet, NSError *error))completion;
- (void)favoriteStatusWithParams:(NSDictionary *)params completion:(void (^)(NSDictionary *tweet, NSError *error)) completion;
- (void)retweetStatusWithParams:(NSDictionary *)params completion:(void (^)(NSDictionary *tweet, NSError *error)) completion;

@end
