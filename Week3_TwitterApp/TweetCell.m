//
//  TweetCell.m
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/8/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@interface TweetCell()
@property (weak, nonatomic) IBOutlet UIImageView *tweetImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    [self.tweetImageView setImageWithURL:[NSURL URLWithString:tweet.imageUrl]];
    self.nameLabel.text = tweet.user.name;
}

@end
