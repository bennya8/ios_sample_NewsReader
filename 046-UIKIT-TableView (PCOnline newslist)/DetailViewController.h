//
//  DetailViewController.h
//  046-UIKIT-TableView (PCOnline newslist)
//
//  Created by Benny on 8/27/14.
//  Copyright (c) 2014 Benny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (assign,nonatomic) NSInteger newsID;

@property (strong,nonatomic) NSString *test;

@property (weak,nonatomic) UIWebView *webview;

@end
