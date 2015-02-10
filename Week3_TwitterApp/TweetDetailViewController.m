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
#import "TwitterClient.h"
#import <SVProgressHUD/SVProgressHUD.H>


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
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UITextField *replyTextField;

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
    
    [self.replyTextField becomeFirstResponder];
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
        self.favoriatesLabel.text = [NSString stringWithFormat:@"--- %ld RETWEETS   -   %ld FAVORIATES ---", tweet.numRetweets, tweet.numFavoriates];
        
        if (tweet.favorited == NO) {
            [self.likeButton setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
        } else {
            [self.likeButton setImage:[UIImage imageNamed:@"favorited.png"] forState:UIControlStateNormal];
        }
        
        if (tweet.retweeted == NO) {
            [self.retweetButton setImage:[UIImage imageNamed:@"retweet.png"] forState:UIControlStateNormal];
        } else {
            [self.retweetButton setImage:[UIImage imageNamed:@"retweeted.png"] forState:UIControlStateNormal];
        }

        
    }
}
- (IBAction)onLikeButtonClick:(id)sender {
}
- (IBAction)onRetweetButtonClick:(id)sender {
}
- (IBAction)onReplyButtonClick:(id)sender {
    NSString *text = self.replyTextField.text;
    NSInteger in_reply_to_status_id = self.tweet.id;
    
    [SVProgressHUD show];
    [SVProgressHUD setBackgroundColor: [UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showInfoWithStatus:@"Sending ..."];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:text forKey:@"status"];
    [dict setValue:[NSString stringWithFormat:@"%ld", in_reply_to_status_id] forKey:@"in_reply_to_status_id"];
    
    [[TwitterClient sharedInstance] updateStatusWithParams:dict completion:^(NSDictionary *tweetDict, NSError *error) {
        if (error == nil) {
            [SVProgressHUD dismiss];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            NSLog(@"Failed sending tweets with error: %@", error);
        }
    }];
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
