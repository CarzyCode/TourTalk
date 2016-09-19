//
//  TTTranstateManager.m
//  TourTalklib
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TTTranstateManager.h"
#import "AFNetworking.h"
#import <UIKit/UIKit.h>
@implementation TTTranstateManager
//+ (TTTranstateManager *)shareTTUser
//{
//    static TTTranstateManager *sharedUserManagerInstance = nil;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        sharedUserManagerInstance = [[self alloc] init];
//    });
//    return sharedUserManagerInstance;
//}
#pragma mark ** 发起翻译
+ (void)TTTranstate:(NSString *)sourceLanguage language:(NSString *)language talkType:(NSString *)talkType block:(TTTranstateBlock)block
{
    
    

    NSString *openId = [[NSUserDefaults standardUserDefaults]objectForKey:@"OPENID"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //增加－－－－本机语言
    //    sourceLanguage
    [dic setObject:sourceLanguage forKey:@"sourceLanguage"];
    //目标语言
    [dic setObject:language forKey:@"language"];
    [dic setObject:openId forKey:@"openId"];
    [dic setObject:talkType forKey:@"talkType"];
    
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", phoneVersion);
    NSString *iosVersion = [NSString stringWithFormat:@"iOS%@",phoneVersion];
    [dic setObject:iosVersion forKey:@"os"];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    NSString *urlStr = [[@"http://182.254.157.150/tourtalk-consumer" stringByAppendingString:@"/translateOrder/requestTranslation."] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = responseObject;
        block(result);
        NSString *code=[responseObject objectForKey:@"stateCode"];
        NSLog(@"code--%@",code);
        NSLog(@"responseObject--%@",responseObject);
        //判断是否成功
        BOOL sucess = [[responseObject objectForKey:@"stateCode"] integerValue] == 100 ? YES : NO;
        if (sucess) {
            //定时器检测发单成功进入视频
//            [self activateTheAnimation];
//            isOrderNo=[NSString stringWithFormat:@"%@",content[@"data"]];
//            if ([isOrderNo isEqualToString:@""] || isOrderNo == nil) {
//                ALERT_SHOW(NSLocalizedString(@"please_resend", @"订单未发成功,请重发") );
//                _waitBGV.hidden = YES;
//                [self destructionOfTheAnimation];
//            }
            //            sender.enabled = YES;
            NSLog(@"--成功");
        }
        else{
            if (![code isEqualToString:@"102"]) {
                //不是102错误 重新发起请求
                NSDictionary*wrongMessage=
                @{
                  @"0":NSLocalizedString(@"system_error_home", @"系统错误(服务器繁忙,请稍候再试)"),
                  @"2000":NSLocalizedString(@"lack_of_gold_COINS_home", @"金币不足") ,
                  @"2001":NSLocalizedString(@"minute_later_try_again_home", @"您的翻译服务操作过于频繁，请稍后再次尝试") ,
                  @"2010" : NSLocalizedString(@"please_try_again_later",@"翻译官繁忙,请稍后重试"),
                  @"2011" : NSLocalizedString(@"please_try_again_later",@"翻译官繁忙,请稍后重试"),
                  @"2012" : NSLocalizedString(@"translation_time_limit_home",@"您好,我们的翻译服务时间是早上9:00-晚上21:00."),
                  @"108" : NSLocalizedString(@"old_please_update_home",@"版本过老,请更新"),
                  @"109" : NSLocalizedString(@"current_device_not_support",@"当前设备不支持")
                  
                  };
                NSLog(@"wrongMessage--%@",wrongMessage[code]);
                if([code isEqualToString:@"2000"]){
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"login_reminder", nil)
//                                                                    message:wrongMessage[content]
//                                                                   delegate:self
//                                                          cancelButtonTitle:NSLocalizedString(@"head_cancel", @"取消")
//                                                          otherButtonTitles:NSLocalizedString(@"login_conform_go_prepaid", @"去充值"), nil];
//                    alert.tag = 1998;
//                    [alert show];
                    
                }else{
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"login_reminder", nil)
//                                                                    message:wrongMessage[content]
//                                                                   delegate:self
//                                                          cancelButtonTitle:nil
//                                                          otherButtonTitles:NSLocalizedString(@"login_conform", @"确认"), nil];
//                    alert.tag = 1997;
//                    [alert show];
                    
                    
                }
                
                
            }

            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error:%@",error);
    }];
    
}

#pragma mark ** 取消翻译
+ (void)TTTranstateCancel:(NSString *)orderNo block:(TTTranstateBlock)block
{
    NSString *openId = [[NSUserDefaults standardUserDefaults]objectForKey:@"OPENID"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:openId forKey:@"openId"];
    [dic setObject:orderNo forKey:@"orderNo"];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    NSString *urlStr = [[@"http://182.254.157.150/tourtalk-consumer" stringByAppendingString:@"/translateOrder/cancelTranslation."] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = responseObject;
        block(result);
        NSString *code=[responseObject objectForKey:@"stateCode"];
        NSLog(@"code--%@",code);
        NSLog(@"responseObject--%@",responseObject);
        //判断是否成功
        BOOL sucess = [[responseObject objectForKey:@"stateCode"] integerValue] == 100 ? YES : NO;
        if (sucess) {
            //定时器检测发单成功进入视频
            //            [self activateTheAnimation];
            //            isOrderNo=[NSString stringWithFormat:@"%@",content[@"data"]];
            //            if ([isOrderNo isEqualToString:@""] || isOrderNo == nil) {
            //                ALERT_SHOW(NSLocalizedString(@"please_resend", @"订单未发成功,请重发") );
            //                _waitBGV.hidden = YES;
            //                [self destructionOfTheAnimation];
            //            }
            //            sender.enabled = YES;
            NSLog(@"--成功");
        }
        else{
            if (![code isEqualToString:@"102"]) {
                //不是102错误 重新发起请求
                NSDictionary*wrongMessage=
                @{
                  @"0":NSLocalizedString(@"system_error_home", @"系统错误(服务器繁忙,请稍候再试)"),
                  @"2000":NSLocalizedString(@"lack_of_gold_COINS_home", @"金币不足") ,
                  @"2001":NSLocalizedString(@"minute_later_try_again_home", @"您的翻译服务操作过于频繁，请稍后再次尝试") ,
                  @"2010" : NSLocalizedString(@"please_try_again_later",@"翻译官繁忙,请稍后重试"),
                  @"2011" : NSLocalizedString(@"please_try_again_later",@"翻译官繁忙,请稍后重试"),
                  @"2012" : NSLocalizedString(@"translation_time_limit_home",@"您好,我们的翻译服务时间是早上9:00-晚上21:00."),
                  @"108" : NSLocalizedString(@"old_please_update_home",@"版本过老,请更新"),
                  @"109" : NSLocalizedString(@"current_device_not_support",@"当前设备不支持")
                  
                  };
                NSLog(@"wrongMessage--%@",wrongMessage[code]);
                if([code isEqualToString:@"2000"]){
                    //                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"login_reminder", nil)
                    //                                                                    message:wrongMessage[content]
                    //                                                                   delegate:self
                    //                                                          cancelButtonTitle:NSLocalizedString(@"head_cancel", @"取消")
                    //                                                          otherButtonTitles:NSLocalizedString(@"login_conform_go_prepaid", @"去充值"), nil];
                    //                    alert.tag = 1998;
                    //                    [alert show];
                    
                }else{
                    //                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"login_reminder", nil)
                    //                                                                    message:wrongMessage[content]
                    //                                                                   delegate:self
                    //                                                          cancelButtonTitle:nil
                    //                                                          otherButtonTitles:NSLocalizedString(@"login_conform", @"确认"), nil];
                    //                    alert.tag = 1997;
                    //                    [alert show];
                    
                    
                }
                
                
            }
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error:%@",error);
    }];

}



@end
