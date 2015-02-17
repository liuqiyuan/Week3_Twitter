//
//  MenuController.m
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/16/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import "MenuController.h"
#import "UIImageView+AFNetworking.h"

NSString * const ClickProfileButtonNotification = @"ClickProfileButtonNotification";
NSString * const ClickTimelineButtonNotification = @"ClickTimelineButtonNotification";
NSString * const ClickMentionsButtonNotification = @"ClickMentionsButtonNotification";

@interface MenuController ()

@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UIButton *homeTimelineButton;
@property (weak, nonatomic) IBOutlet UIButton *mentionsButton;
@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapImage)];
    tap.numberOfTapsRequired = 1;
    [self.menuImageView addGestureRecognizer:tap];
    [self.menuImageView setUserInteractionEnabled:YES];
    
    self.menuImageView.layer.cornerRadius = 5;
    self.menuImageView.clipsToBounds = YES;
    [self.menuImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    self.usernameLabel.text = self.user.screenName;
}
- (void)onTapImage {
    NSLog(@"Profile image clicked");
    [[NSNotificationCenter defaultCenter] postNotificationName:ClickProfileButtonNotification object:nil];
}

- (IBAction)onProfileButtonClick:(id)sender {
    NSLog(@"Profile button clicked");
    [[NSNotificationCenter defaultCenter] postNotificationName:ClickProfileButtonNotification object:nil];
}
- (IBAction)onHomelineButtonClick:(id)sender {
    NSLog(@"Timeline button clicked");
    [[NSNotificationCenter defaultCenter] postNotificationName:ClickTimelineButtonNotification object:nil];
}
- (IBAction)onMentionsButtonClick:(id)sender {
    NSLog(@"Mentions button clicked");
    [[NSNotificationCenter defaultCenter] postNotificationName:ClickMentionsButtonNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
