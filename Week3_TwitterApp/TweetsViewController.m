//
//  TweetsViewController.m
//  Week3_TwitterApp
//
//  Created by Qiyuan Liu on 2/8/15.
//  Copyright (c) 2015 liuqiyuan.com. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "TweetDetailViewController.h"
#import <SVProgressHUD/SVProgressHUD.H>

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIRefreshControl *refreshController;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *tweetsArray;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set navigation bar
    self.title = @"Tweets";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogOutSelector)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNewSelector)];
    
    // Set refresh controll
    self.refreshController = [[UIRefreshControl alloc]init];
    [self.refreshController addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshController atIndex:0];
    
    // Set table view & its cell
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Add observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchDataWithoutCall:) name:UserDidComposeNotification object:nil];
    
    // Fetch data
    [self fetchData];
}

- (void)onLogOutSelector {
    [User logout];
}

- (void)onNewSelector {
    ComposeViewController *vc = [[ComposeViewController alloc] init];
    vc.user = [User currentUser];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma - table view actions

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    [cell setTweet:self.tweetsArray[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.prototypeCell setTweet:self.tweetsArray[indexPath.row]];
    [self.prototypeCell layoutIfNeeded];
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetDetailViewController *vc = [[TweetDetailViewController alloc] init];
    [vc setTweet:self.tweetsArray[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma - api functions 
- (void)fetchDataWithoutCall: (NSNotification *) notification {
    NSDictionary *dict = notification.userInfo;
    Tweet *tweet = [[Tweet alloc]initWithDictionary:dict];
    
    if (tweet != nil) {
        NSMutableArray *newArray = [[NSMutableArray alloc]initWithObjects:tweet, nil];
        [newArray addObjectsFromArray:self.tweetsArray];
        self.tweetsArray = newArray;
        [self.tableView reloadData];
    }
}

- (void)fetchData {
    [SVProgressHUD show];
    [SVProgressHUD setBackgroundColor: [UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showInfoWithStatus:@"Loading ..."];
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        if (error == nil) {
           
            self.tweetsArray = tweets;
        
            [self.tableView reloadData];
            [self.refreshController endRefreshing];
            [SVProgressHUD dismiss];
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
