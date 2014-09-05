//
//  DetailViewController.m
//  046-UIKIT-TableView (PCOnline newslist)
//
//  Created by Benny on 8/27/14.
//  Copyright (c) 2014 Benny. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"新闻详情"];
    
    UIWebView *webview = [[UIWebView alloc]init];
    [webview setBackgroundColor:[UIColor whiteColor]];
    
    if (__IOS_7) {
        [webview setFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    }else{
        [webview setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
    }
    
    for (UIView *aView in [webview subviews]){
        if ([aView isKindOfClass:[UIScrollView class]]){
            [(UIScrollView *)aView setShowsVerticalScrollIndicator:NO];
            for (UIView *shadowView in aView.subviews){
                if ([shadowView isKindOfClass:[UIImageView class]]){
                    shadowView.hidden = YES;
                }
            }
        }
    }
    [self.view addSubview: webview];
    self.webview = webview;

    NSString *url = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v3/cms/articles/%d",self.newsID];
    
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self.webview loadRequest:request];

}

@end
