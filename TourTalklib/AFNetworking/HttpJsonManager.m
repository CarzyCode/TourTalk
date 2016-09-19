//
//  HttpJsonManager.m
//  VPImageCropperDemo
//
//  Created by 范宇 on 14/11/25.
//  Copyright (c) 2014年 Vinson.D.Warm. All rights reserved.
//

#import "HttpJsonManager.h"
static NSString *cookieValue;
@implementation HttpJsonManager

+ (void)postWithParameters:(NSDictionary *)params
                      url:(NSString *)url
                isEncrypt:(NSString *)Encrypt
        completionHandler:(void (^)(BOOL, id))completion
{
    
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0), ^{
    //  ISCONNECT
      HttpJsonManager *manager = [HttpJsonManager manager];
      manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];;
      manager.responseSerializer = [AFJSONResponseSerializer serializer];
      NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
       {

           NSString *code=[responseObject objectForKey:@"stateCode"];
           //判断是否成功
           BOOL sucess = [[responseObject objectForKey:@"stateCode"] integerValue] == 100 ? YES : NO;
           //根据成功与否，返回相应值
           if (sucess){
               completion(YES, responseObject);
               
           }
           else{
               if ([code isEqualToString:@"102"]) {
//                   您的帳號已在別處登入，請重新登入
//                ALERT_SHOW(NSLocalizedString(@"log_back_in", @"您的账号已在别处登录,请重新登录"));
//                   CyberLoginVC*vc=[[CyberLoginVC alloc]init];
//                   vc.isPresent=YES;
//                    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:vc];
//                   [viewController presentViewController:loginNav animated:YES completion:nil];
                   completion(NO, code);
              
               }else{
                   completion(NO, code);

               }
           }
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"error ===== %@",error);
           [[NSNotificationCenter defaultCenter]postNotificationName:@"NotFoundTheNetwork" object:self userInfo:nil];

           /*数据请求判断*/
               if (error.code == -1001) {
                   /*网络超时*/
//                   [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"login_connectlong", nil)];
               }
               else if (error.code == -1004 || error.code == -1009) {
                   /*无网络连接*/
                   [manager.operationQueue cancelAllOperations];
//                   [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"login_connectfail", nil)];
               }
               else if (error.code == -999) {
                   /*主动停止网络*/
                   [manager.operationQueue cancelAllOperations];
               }else{
//                   [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"login_connectfail", nil)];
               }
           }];
      
  });

}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{

    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    if (cookieValue)
    {   //如果以获取到cookie值，那么就加入发送的请求的header中
        NSLog(@"%@",cookieValue);
        [request setValue:cookieValue forHTTPHeaderField:@"Cookie"];
    }
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request
                                                                      success:success
                                                                      failure:failure];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

@end
