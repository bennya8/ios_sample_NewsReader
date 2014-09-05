//
//  NewsFocus.m
//  046-UIKIT-TableView (PCOnline newslist)
//
//  Created by Benny on 8/27/14.
//  Copyright (c) 2014 Benny. All rights reserved.
//

#import "NewsFocusCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation NewsFocusCell
{
    NSArray *_data;
}

- (void)awakeFromNib
{
    // Initialization code
//    NSLog(@"%@", self.scrollView);
    
    
    [self.scrollView setDelegate:self];
    [self.scrollView setAlwaysBounceHorizontal:NO];
    [self.scrollView setPagingEnabled:YES];
    
    [self.pageControll setNumberOfPages:self.newsFocusList.count];
    [self.pageControll addTarget:self action:@selector(pageControllDidValueChange:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)setNewsFocusList:(NSArray *)newsFocusList
{
    _newsFocusList = newsFocusList;
    [self.pageControll setNumberOfPages:self.newsFocusList.count];
    
    CGFloat width = self.scrollView.bounds.size.width;
    CGFloat height = self.scrollView.bounds.size.height;
    
    [self.scrollView setContentSize:CGSizeMake(_newsFocusList.count * width, height)];
    
    for (NSInteger i = 0; i < _newsFocusList.count; i++) {
        NSDictionary *newsFocus = _newsFocusList[i];
        UIImageView *thumb = [[UIImageView alloc]init];
        [thumb setFrame:CGRectMake(i * width, 0, width, height)];
        NSURL *thumbUrl = [NSURL URLWithString:newsFocus[@"image"]];
        [thumb sd_setImageWithURL:thumbUrl];
        [self.scrollView addSubview:thumb];
    }

}

#pragma mark - actions
- (void)pageControllDidValueChange:(UIPageControl *)pageControll
{
    NSInteger pIndex = pageControll.currentPage;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width * pIndex, 0) animated:YES];
}

#pragma mark - delegates
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    [self.pageControll setCurrentPage:pIndex];
}

@end
