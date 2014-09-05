//
//  NewsFocus.h
//  046-UIKIT-TableView (PCOnline newslist)
//
//  Created by Benny on 8/27/14.
//  Copyright (c) 2014 Benny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsFocusCell : UITableViewCell
<UIScrollViewDelegate>

@property (strong,nonatomic) NSArray *newsFocusList;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControll;

@end
