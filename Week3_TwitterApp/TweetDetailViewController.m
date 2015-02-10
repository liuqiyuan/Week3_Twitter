//
//  TweetDetailViewController.m
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/9/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Utils.h"


@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTextView;
@property (weak, nonatomic) IBOutlet UILabel *createdDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriatesLabel;
@property (weak, nonatomic) IBOutlet UIView *viewBox;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.viewBox.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.viewBox.layer.borderWidth = 1.0f;
    [self setTweetProperties:self.tweet];
    self.detailImageView.layer.cornerRadius = 5;
    self.detailImageView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTweetProperties:(Tweet *)tweet {
    if (tweet) {
        self.nameLabel.text = tweet.user.name;
        self.idLabel.text = tweet.user.screenName;
        [self.detailImageView setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
        self.detailTextView.text = tweet.text;
        self.createdDateLabel.text = [Utils calculateDateDiff:tweet.createdDate];
        self.favoriatesLabel.text = [NSString stringWithFormat:@"--- %@ RETWEETS   -   %@ FAVORIATES ---", tweet.numRetweets, tweet.numFavoriates];
    }
}
- (IBAction)onLikeButtonClick:(id)sender {
}
- (IBAction)onRetweetButtonClick:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
