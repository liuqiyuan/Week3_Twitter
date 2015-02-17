//
//  ProfileController.m
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/16/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import "ProfileController.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"
#import "TwitterClient.h"


@interface ProfileController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLable;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *tweetsArray;

@end

@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Me";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogOutSelector)];
    
    // Set table view properties
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.profileImage.layer.cornerRadius = 50;
    self.profileImage.clipsToBounds = YES;
    
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    self.tweetsLable.text = [NSString stringWithFormat:@"%ld Tweets", (long)self.user.numTweets];
    self.followingLabel.text = [NSString stringWithFormat:@"%ld Following", (long)self.user.numFollowing];
    self.followersLabel.text = [NSString stringWithFormat:@"%ld Followers", (long)self.user.numFollowers];
    
    
    // Fetch data
    [self fetchData];
}

- (void)fetchData {
    NSDictionary *dict = @{
                           @"screen_name": self.user.screenName
                           };
    [[TwitterClient sharedInstance] userTimelineWithParams:dict completion:^(NSArray *tweets, NSError *error) {
        if (error == nil) {
            self.tweetsArray = tweets;
            [self.tableView reloadData];
        } else {
            NSLog(@"Error fetching data: %@", error);
        }
    }];
}

#pragma - setter for prototype cell
- (TweetCell *)prototypeCell {
    if (!_prototypeCell) {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    }
    return _prototypeCell;
}

#pragma - table view actions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    [cell setTweet:self.tweetsArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.prototypeCell setTweet:self.tweetsArray[indexPath.row]];
    [self.prototypeCell layoutIfNeeded];
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onLogOutSelector {
    [User logout];
}

@end
