//
//  RootViewController.m
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/16/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import "RootViewController.h"
#import "MenuController.h"
#import "TweetsViewController.h"
#import "ProfileController.h"
#import "MentionsController.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) MenuController *menuController;
@property (nonatomic, strong) UINavigationController *profileController;
@property (nonatomic, strong) MentionsController *mentionsController;
@property (nonatomic, strong) UINavigationController *timelineController;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Register observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onClickProfile) name:ClickProfileButtonNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onClickTimeline) name:ClickTimelineButtonNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onClickMentions) name:ClickMentionsButtonNotification object:nil];
    
    self.menuController = [[MenuController alloc]init];
    [self.menuController setUser:self.user];
    
    ProfileController *profileController = [[ProfileController alloc]init];
    [profileController setUser:self.user];
    self.profileController = [[UINavigationController alloc]initWithRootViewController:profileController];
    
    self.mentionsController = [[MentionsController alloc]init];
    [self.mentionsController setUser:self.user];
    
    TweetsViewController *tvc = [[TweetsViewController alloc]init];
    self.timelineController = [[UINavigationController alloc]initWithRootViewController:tvc];
    
    [self.contentView addSubview:self.profileController.view];
    self.profileController.view.frame = self.contentView.frame;
    [self.contentView addSubview:self.menuController.view];
    
    // Original frame for menu controller
    [self hideMenu];
    
    
}

- (IBAction)onPanDrag:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:sender.view];
    CGPoint velocity = [sender velocityInView:sender.view];
    NSLog(@"translation x %f y %f", translation.x, translation.y);
    NSLog(@"velocity x %f y %f", velocity.x, velocity.y);

    if (sender.state == UIGestureRecognizerStateBegan) {
    } else if (sender.state == UIGestureRecognizerStateChanged) {
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        if (velocity.x > 0) {
            CGRect frame = self.menuController.view.frame;
            frame.origin.x = 0;
            [UIView animateWithDuration:0.6 animations:^{
                self.menuController.view.frame = frame;
            }];
        } else {
            CGRect frame = self.menuController.view.frame;
            frame.origin.x = - frame.size.width;
            [UIView animateWithDuration:0.6 animations:^{
                self.menuController.view.frame = frame;
            }];
        }
    }
}

- (void)hideMenu {
    CGRect frame = self.menuController.view.frame;
    frame.origin.x = - frame.size.width;
    self.menuController.view.frame = frame;
}

- (void)hideMenuWithAnimation {
    [UIView animateWithDuration:0.6 animations:^{
        CGRect frame = self.menuController.view.frame;
        frame.origin.x = - frame.size.width;
        self.menuController.view.frame = frame;
    }];
}


- (void)onClickProfile {
    [self.contentView addSubview:self.profileController.view];
    self.profileController.view.frame = self.contentView.frame;
    [self.contentView addSubview:self.menuController.view];
    [self hideMenuWithAnimation];
}

- (void)onClickTimeline {
    [self.contentView addSubview:self.timelineController.view];
    self.timelineController.view.frame = self.contentView.frame;
    [self.contentView addSubview:self.menuController.view];
    [self hideMenuWithAnimation];
}

- (void)onClickMentions {
    [self.contentView addSubview:self.mentionsController.view];
    self.mentionsController.view.frame = self.contentView.frame;
    [self.contentView addSubview:self.menuController.view];
    [self hideMenuWithAnimation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
