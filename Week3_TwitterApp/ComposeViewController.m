//
//  ComposeViewController.m
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/9/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import "ComposeViewController.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetsViewController.h"
#import "UIImageView+AFNetworking.h"
#import <SVProgressHUD/SVProgressHUD.H>

NSString * const UserDidComposeNotification = @"UserDidComposeNotification";

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *composeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *composeTextView;

@end

@implementation ComposeViewController

- (id)initWithUser: (User *) user {
    self = [super init];
    
    if (self) {
        [self.composeImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
        self.nameLabel.text = self.user.name;
        self.idLabel.text = @"test";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set navigation bar
    self.title = @"Compose";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelCompose)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(onSendTweet)];
    
    [self.composeImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    self.nameLabel.text = self.user.name;
    self.idLabel.text = self.user.screenName;
    [self.composeTextView becomeFirstResponder];
}

- (void)onCancelCompose {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)onSendTweet {
    NSString *text = self.composeTextView.text;
    
    [SVProgressHUD show];
    [SVProgressHUD setBackgroundColor: [UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showInfoWithStatus:@"Sending ..."];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:text forKey:@"status"];
    
    [[TwitterClient sharedInstance] updateStatusWithParams:dict completion:^(NSDictionary *tweetDict, NSError *error) {
        if (error == nil) {
            [SVProgressHUD dismiss];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            // Send notification
            [[NSNotificationCenter defaultCenter] postNotificationName:UserDidComposeNotification object:nil userInfo:tweetDict];
        } else {
            NSLog(@"Failed sending tweets with error: %@", error);
        }
    }];
}

#pragma - setter for tweet
- (void)setUser:(User *)user {
    _user = user;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
