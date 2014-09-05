//
//  MainViewController.m
//  046-UIKIT-TableView (PCOnline newslist)
//
//  Created by Benny on 8/27/14.
//  Copyright (c) 2014 Benny. All rights reserved.
//

#import "AppDelegate.h"
#import "DDMenuController.h"
#import "MainViewController.h"
#import "DetailViewController.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "NewsFocusCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "MJRefresh.h"

static NSString *newCellId = @"NewsCell";

static NSString *newFocusCellId = @"NewsFocusCell";

@interface MainViewController ()

@property (strong,nonatomic) UIRefreshControl *refreshControl;

@property (strong,nonatomic) NewsModel *newsModel;

@property (strong,nonatomic) NSArray *newsFocusList;

@property (strong,nonatomic) NSArray *newsList;

@property (assign,nonatomic) NSInteger newsTotal;

@property (assign,nonatomic) NSInteger newsPageNo;

@property (assign,nonatomic) NSInteger newsPageSize;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self viewInit];
//    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 100.0f)];
//    [self.refreshControl addTarget:self action:@selector(headerReloadControl:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView.tableHeaderView addSubview:self.refreshControl];
    self.newsModel = [[NewsModel alloc]init];
    self.newsPageNo = 1;
    self.newsPageSize = 20;
    
    // news cell xib
    UINib *newsFocusCell = [UINib nibWithNibName:newFocusCellId bundle:nil];
    [self.tableView registerNib:newsFocusCell forCellReuseIdentifier:newFocusCellId];
    
    UINib *newsCell = [UINib nibWithNibName:newCellId bundle:nil];
    [self.tableView registerNib:newsCell forCellReuseIdentifier:newCellId];
    
    // register pull refreshing
    [self.tableView addHeaderWithTarget:self action:@selector(headerReloadControl)];
    [self.tableView addFooterWithTarget:self action:@selector(footerReloadControl)];
    [self.tableView headerBeginRefreshing];
}

- (void)viewInit
{
    if (__IOS_7) {
        UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init];
        [backbutton setTitle:@""];
        self.navigationItem.backBarButtonItem = backbutton;
    }else{
        UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init];
        [backbutton setTitle:@"返回"];
        self.navigationItem.backBarButtonItem = backbutton;
    }
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"分类" style:UIBarButtonItemStyleBordered target:self action:@selector(leftMenuToggle)];
    self.navigationItem.leftBarButtonItem = leftItem;

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"用户" style:UIBarButtonItemStyleBordered target:self action:@selector(rightMenuToggle)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)footerReloadControl
{
    NSDictionary *params = @{
                             @"pageNo":[NSString stringWithFormat:@"%d",self.newsPageNo + 1],
                             @"pageSize":[NSString stringWithFormat:@"%d",self.newsPageSize]
                             };
    [self.newsModel newsListWithParams:params success:^(NSDictionary *data, NSError *error) {
        if(error == nil){
            NSInteger capacity = self.newsList.count + [data[@"pageSize"]integerValue];
            NSMutableArray *temp = [NSMutableArray arrayWithCapacity:capacity];
            for (NSDictionary *news in self.newsList) {
                [temp addObject:news];
            }
            for (NSDictionary *news in data[@"articleList"]) {
                [temp addObject:news];
            }
            self.newsList = temp;
            self.newsTotal = [data[@"total"]integerValue];
            self.newsPageNo = [data[@"pageNo"]integerValue];
            self.newsPageSize = [data[@"pageSize"]integerValue];
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];
        }
    }];

}

- (void)headerReloadControl
{
    self.newsPageNo = 1;
    NSDictionary *params = @{
                             @"pageNo":[NSString stringWithFormat:@"%d",self.newsPageNo],
                             @"pageSize":[NSString stringWithFormat:@"%d",self.newsPageSize]
                             };
    [self.newsModel newsListWithParams:params success:^(NSDictionary *data, NSError *error) {
        if(error == nil){
            self.newsList = data[@"articleList"];
            self.newsFocusList = data[@"focus"];
            self.newsTotal = [data[@"total"]integerValue];
            self.newsPageNo = [data[@"pageNo"]integerValue];
            self.newsPageSize = [data[@"pageSize"]integerValue];
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        NewsFocusCell *newsFocusCell = [tableView dequeueReusableCellWithIdentifier:newFocusCellId];
        [newsFocusCell setNewsFocusList:self.newsFocusList];
        cell = newsFocusCell;
    }else{
        NewsCell *newsCell = [tableView dequeueReusableCellWithIdentifier:newCellId];
        
        NSDictionary *news = self.newsList[indexPath.row - 1];
        
        NSURL *thumbUrl = [NSURL URLWithString:news[@"image"]];
        [newsCell.newsThumb sd_setImageWithURL:thumbUrl];
        [newsCell.newsTitle setText:news[@"title"]];
        [newsCell.newsPostTime setText:news[@"pubDate"]];
        [newsCell.newsComments setText:[NSString stringWithFormat:@"%d 评论",[news[@"cmtCount"]integerValue]]];
        
        cell = newsCell;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsList.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 160.0;
    }else{
        return 80.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    UITouch *touch = [[UITouch alloc]init];
//    CGPoint point = [touch locationInView:self.tableView];
//    NSIndexPath *index = [self.tableView indexPathForRowAtPoint:point];
    NSDictionary *newsDict = self.newsList[indexPath.row - 1];
    [self performSegueWithIdentifier:@"NewsDetailSegue" sender:newsDict];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = [segue identifier];
    if ([identifier isEqualToString:@"NewsDetailSegue"]) {
        NSDictionary *newsDict = sender;
        DetailViewController *next = [segue destinationViewController];
        next.newsID = [newsDict[@"id"]integerValue];
    }
}

#pragma mark - actions
- (void)leftMenuToggle
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app.contentVC showLeftController:YES];
}

- (void)rightMenuToggle
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app.contentVC showRightController:YES];
}

@end
