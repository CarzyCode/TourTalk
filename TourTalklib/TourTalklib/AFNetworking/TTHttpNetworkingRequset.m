//
//  TTHttpNetworkingRequset.m
//  TourTalklib
//
//  Created by apple on 16/9/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TTHttpNetworkingRequset.h"
#import "AFNetworking.h"

@implementation TTHttpNetworkingRequset


+ (void)getDataWithURL:(NSString *)urlStr block:(AppToolBlock)block
{
    NSString *urlEncode = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager GET:urlEncode parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"使用AFN进行get请求 ===  %@",responseObject);
        
        //block回调
        block(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //        //结束下拉上拉刷新
        //        [self.myTableView headerEndRefreshing];
        //        [self.myTableView footerEndRefreshing];
        
        NSLog(@"失败==== %@",error);
        
    }];

}

+ (void)postDataWithURL:(NSString *)urlStr  parameters:(id)parameters block:(AppToolBlock)block
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败==== %@",error);
    }];
}

@end
