//
//  TTUserMessageManager.m
//  TourTalklib
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TTUserMessageManager.h"
#import "sys/utsname.h"
#import "HttpJsonManager.h"
#import "AFNetworking.h"
#import <CloudPushSDK/CloudPushSDK.h>
#import "TTDeviceVersion.h"
@implementation TTUserMessageManager


+ (void)TTUserLoginAction:(NSString *)UserNum UserPassWord:(NSString *)UserPassWord block:(TTUserBlock)block
{
    
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *app_version = [user objectForKey:@"VersionString"];
//    [paramsDict setObject:app_version forKey:@"version"];
    //手机型号iphone6
    [paramsDict setObject:[TTDeviceVersion getDeviceVersinon] forKey:@"device"];
    
    [paramsDict setObject:UserNum forKey:@"account"];
    [paramsDict setObject:@"iOS" forKey:@"os"];
    [paramsDict setObject:UserPassWord forKey:@"password"];
    [paramsDict setObject:[CloudPushSDK getDeviceId] forKey:@"deviceId"];
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    NSString *urlStr = [[@"http://182.254.157.150/tourtalk-consumer" stringByAppendingString:@"/customer/login."] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paramsDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = responseObject;
        block(result);
        NSLog(@"responseObject%@",responseObject);
        NSString *code=[responseObject objectForKey:@"stateCode"];
        NSLog(@"code--%@",code);
        //判断是否成功
        BOOL sucess = [[responseObject objectForKey:@"stateCode"] integerValue] == 100 ? YES : NO;
        //根据成功与否，返回相应值
        if (sucess){
            NSString*message=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [[NSUserDefaults standardUserDefaults] setObject:message forKey:@"OPENID"];
            NSString*customerId=[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"customerId"]];
            [[NSUserDefaults standardUserDefaults] setObject:customerId forKey:@"customerId"];
            }
        else{
            if ([code isEqualToString:@"102"]) {
                //                   您的帳號已在別處登入，請重新登入
                //                ALERT_SHOW(NSLocalizedString(@"log_back_in", @"您的账号已在别处登录,请重新登录"));
                //                   CyberLoginVC*vc=[[CyberLoginVC alloc]init];
                //                   vc.isPresent=YES;
                //                    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:vc];
                //                   [viewController presentViewController:loginNav animated:YES completion:nil];
                
                NSLog(@"TourTalk用户账号已在别处，請重新登入");
            }else{
                
                
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败==== %@",error);
    }];
}
#pragma mark ** 注册
+ (void)TTUserResgisterAction:(NSString *)UserNum inviteCode:(NSString *)inviteCode UserPassWord:(NSString *)UserPassWord UserNickName:(NSString *)UserNickName block:(TTUserBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
        
        //邀请码
        [paramsDict setObject:inviteCode forKey:@"inviteCode"];
        [paramsDict setObject:UserNickName forKey:@"nickname"];
        [paramsDict setObject:UserPassWord forKey:@"password"];
        [paramsDict setObject:UserNum forKey:@"account"];
        [paramsDict setObject:@"ios" forKey:@"os"];
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
        NSString *urlStr = [[@"http://182.254.157.150/tourtalk-consumer" stringByAppendingString:@"/customer/register."] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager POST:urlStr parameters:paramsDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            id result = responseObject;
            block(result);
            NSLog(@"-register-%@",responseObject);
            NSString *code = [responseObject objectForKey:@"stateCode"];
            NSString *msg = [responseObject objectForKey:@"message"];
            NSLog(@"code--%@",code);
            NSLog(@"msg--%@",msg);
            if ([code isEqualToString:@"100"]){
                
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary*wrongMessage=
                    @{
                      @"1002":@"用户已存在",
                      @"1007":@"账号不符合规矩",
                      @"1009":@"请输入密码",
                      @"1011":@"昵称不符合规矩",
                      @"1006":@"请输入账号",
                      @"1008":@"密码不符合规矩",
                      @"1010":@"昵称为空",
                      @"3000":@"邀请码不存在",
                      @"3001":@"邀请码不在规定时间内"
                      };
                    NSLog(@"%@",wrongMessage[code]);
                });
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            /*数据请求判断*/
            if (error.code == -1001) {
                /*网络超时*/
//                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"login_connectlong", nil)];
            }
            else if (error.code == -1004 || error.code == -1009) {
                /*无网络连接*/
//                [manager.operationQueue cancelAllOperations];
//                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"login_connectfail", nil)];
            }
            else if (error.code == -999) {
                /*主动停止网络*/
//                [manager.operationQueue cancelAllOperations];
            }
//            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"login_connectfail", nil)];
            
        }];
    });
    

}

#pragma mark ** 登出
+ (void)TTUserOutLoginAction:(TTUserBlock)block
{
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    
    NSString *openId = [[NSUserDefaults standardUserDefaults]objectForKey:@"OPENID"];
    [paramsDict setObject:openId forKey:@"openId"];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    NSString *urlStr = [[@"http://182.254.157.150/tourtalk-consumer" stringByAppendingString:@"/customer/logout."] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:paramsDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = responseObject;
        block(result);
        
        NSString *code=[responseObject objectForKey:@"stateCode"];
        //判断是否成功
        BOOL sucess = [[responseObject objectForKey:@"stateCode"] integerValue] == 100 ? YES : NO;
        //根据成功与否，返回相应值
        if (sucess){
            [[NSUserDefaults standardUserDefaults] setObject:@" " forKey:@"OPENID"];
            
        }
        else{
            if ([code isEqualToString:@"102"]) {
                //                   您的帳號已在別處登入，請重新登入
                
            }else{
                
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}
@end
