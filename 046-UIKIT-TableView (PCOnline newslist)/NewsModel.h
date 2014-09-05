//
//  NewsModel.h
//  046-UIKIT-TableView (PCOnline newslist)
//
//  Created by Benny on 8/27/14.
//  Copyright (c) 2014 Benny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

- (void) newsListWithParams:(NSDictionary *)params success:(void (^)(NSDictionary *data, NSError *error))block;

@end
