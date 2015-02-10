//
//  TweetCell.m
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/8/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "Utils.h"
#import "TwitterClient.h"
#import <SVProgressHUD/SVProgressHUD.H>


@interface TweetCell()
@property (weak, nonatomic) IBOutlet UIImageView *tweetImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
    
    self.tweetTextLabel.preferredMaxLayoutWidth = self.tweetTextLabel.frame.size.width;
    self.tweetImageView.layer.cornerRadius = 5;
    self.tweetImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onFavoriteButtonClick:(id)sender {
    NSInteger id_status = self.tweet.id;
    NSNumber *theNum = [NSNumber numberWithInteger:id_status];
    
    [SVProgressHUD show];
    [SVProgressHUD setBackgroundColor: [UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showInfoWithStatus:@"Mark Favorite"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:theNum forKey:@"id"];
    
    [[TwitterClient sharedInstance] favoriteStatusWithParams:dict completion:^(NSDictionary *tweet, NSError *error) {
        if (error != nil) {
            [SVProgressHUD dismiss];
            self.tweet.numFavoriates = 1;
            self.favoriteLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.numFavoriates];
        } else {
            NSLog(@"Failed to favorite a status: %@", error);
        }
    }];
}
- (IBAction)onRetweetButtonClick:(id)sender {
    NSInteger id_status = self.tweet.id;
    NSNumber *theNum = [NSNumber numberWithInteger:id_status];
    
    [SVProgressHUD show];
    [SVProgressHUD setBackgroundColor: [UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showInfoWithStatus:@"Retweeting"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:theNum forKey:@"id"];
    
    [[TwitterClient sharedInstance] retweetStatusWithParams:dict completion:^(NSDictionary *tweet, NSError *error) {
        if (error != nil) {
            [SVProgressHUD dismiss];
            self.tweet.numRetweets = 1;
            self.retweetLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.numRetweets];
        } else {
            NSLog(@"Failed to retweet a status: %@", error);
        }
    }];

}
- (IBAction)onReplyButton:(id)sender {
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    [self.tweetImageView setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    self.nameLabel.text = tweet.user.name;
    self.idLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.createdDateLabel.text = [Utils calculateDateDiff:tweet.createdDate];
    self.tweetTextLabel.text = tweet.text;
    self.favoriteLabel.text = [NSString stringWithFormat:@"%ld", tweet.numFavoriates];
    self.retweetLabel.text = [NSString stringWithFormat:@"%ld", tweet.numRetweets];
}

@end
