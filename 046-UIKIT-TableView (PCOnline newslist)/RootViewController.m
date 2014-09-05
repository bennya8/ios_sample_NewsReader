//
//  RootViewController.m
//  046-UIKIT-TableView (PCOnline newslist)
//
//  Created by Benny on 8/28/14.
//  Copyright (c) 2014 Benny. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    if (__IOS_7) {
        self.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationBar.barTintColor = [UIColor colorWithRed:.4 green:.8 blue:1 alpha:1];
        self.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor]};
    }else{
        self.navigationBar.tintColor = [UIColor colorWithRed:.4 green:.8 blue:1 alpha:1];
    }
    
    
    
    
//    [self.navigationBar setBackgroundColor:[UIColor whiteColor]];
//    self.navigationBar.barTintColor = [UIColor blueColor];
//    self.navigationBar.translucent = YES;
    
    
//    NSLog(@"%@",self.navigationBar.barTintColor);
    

}

@end
