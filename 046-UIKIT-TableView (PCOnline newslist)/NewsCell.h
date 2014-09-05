//
//  NewsCell.h
//  046-UIKIT-TableView (PCOnline newslist)
//
//  Created by Benny on 8/27/14.
//  Copyright (c) 2014 Benny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *newsThumb;

@property (weak, nonatomic) IBOutlet UILabel *newsTitle;

@property (weak, nonatomic) IBOutlet UILabel *newsPostTime;

@property (weak, nonatomic) IBOutlet UILabel *newsComments;

@end
