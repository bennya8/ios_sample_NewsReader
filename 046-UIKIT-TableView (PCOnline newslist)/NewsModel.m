//
//  NewsModel.m
//  046-UIKIT-TableView (PCOnline newslist)
//
//  Created by Benny on 8/27/14.
//  Copyright (c) 2014 Benny. All rights reserved.
//

#import "NewsModel.h"
#import "AFNetworking/AFNetworking.h"

@implementation NewsModel


- (void)newsListWithParams:(NSDictionary *)params success:(void (^)(NSDictionary *, NSError *))block
{
    NSString *url = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v2/cms/channels/1"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSJSONSerialization *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dict = (NSDictionary *)jsonObject;
        if (block) {
            block(dict,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil,error);
        }
    }];

}

@end
