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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:nil];
    
    // Set refresh controll
    self.refreshController = [[UIRefreshControl alloc]init];
    [self.refreshController addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshController atIndex:0];
    
    // Set table view & its cell
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Fetch data
    [self fetchData];
}

- (void)onLogOutSelector {
    [User logout];
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

#pragma - api functions 
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
