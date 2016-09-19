//
//  TTReservationManager.m
//  TourTalklib
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TTReservationManager.h"
#import "TTDeviceVersion.h"
#import "AFNetworking.h"
#import <UIKit/UIKit.h>
@implementation TTReservationManager

+ (void)TTReservation:(NSString *)userLanguage type:(NSString *)type block:(TTReservationBlock)block
{
    NSString *openId = [[NSUserDefaults standardUserDefaults]objectForKey:@"OPENID"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:openId forKey:@"openId"];
    [dic setObject:type forKey:@"type"];
    
    [dic setObject:[TTDeviceVersion getCurrentLanguage] forKey:@"language"];
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", phoneVersion);
    NSString *iosVersion = [NSString stringWithFormat:@"iOS%@",phoneVersion];
    [dic setObject:iosVersion forKey:@"os"];
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    NSString *urlStr = [[@"http://182.254.157.150/tourtalk-consumer" stringByAppendingString:@"/translateOrder/requestServers."] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = responseObject;
        block(result);
        NSString *code=[responseObject objectForKey:@"stateCode"];
        NSLog(@"code--%@",code);
        //判断是否成功
        BOOL sucess = [[responseObject objectForKey:@"stateCode"] integerValue] == 100 ? YES : NO;
        if (sucess) {
//            UILabel *lab;
//            if (type == 2) {
//                lab = (UILabel *)[self.view viewWithTag:1000];
//                lab.text = NSLocalizedString(@"Contact_customer_service", @"正在帮您联系客服...");
//            }else if (type == 3){
//                lab = (UILabel *)[self.view viewWithTag:1001];
//                lab.text = NSLocalizedString(@"Contact_customer_service", @"正在帮您联系客服...");
//            }
//            _timerOrder =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(TimeRefresh) userInfo:nil repeats:YES];
//            
//            isOrderNo=[NSString stringWithFormat:@"%@",content[@"data"]];
//            if ([isOrderNo isEqualToString:@""] || isOrderNo == nil) {
//                ALERT_SHOW(NSLocalizedString(@"please_resend", @"订单未发成功,请重发") );
//            }
        }
        else{
//            UILabel *lab;
//            if (type == 2) {
//                lab = (UILabel *)[self.view viewWithTag:1000];
//                lab.text = NSLocalizedString(@"About_the_car_service",@"约车服务");
//            }else if (type == 3){
//                lab = (UILabel *)[self.view viewWithTag:1001];
//                lab.text = NSLocalizedString(@"Order_a_meal_service",@"订餐服务");
//            }
//            
//            if (![content isEqualToString:@"102"]) {
//                //不是102错误 重新发起请求
//                NSDictionary*wrongMessage=
//                @{
//                  @"0":NSLocalizedString(@"system_error_home", @"系统错误(服务器繁忙,请稍候再试)"),
//                  @"2000":NSLocalizedString(@"lack_of_gold_COINS_home", @"金币不足") ,
//                  @"2001":NSLocalizedString(@"minute_later_try_again_home", @"您的翻译服务操作过于频繁，请稍后再次尝试") ,
//                  @"2010" : NSLocalizedString(@"please_try_again_later",@"翻译官繁忙,请稍后重试"),
//                  @"2011" : NSLocalizedString(@"please_try_again_later",@"翻译官繁忙,请稍后重试"),
//                  @"2012" : NSLocalizedString(@"translation_time_limit_home",@"您好,我们的翻译服务时间是早上9:00-晚上21:00."),
//                  @"108" : NSLocalizedString(@"old_please_update_home",@"版本过老,请更新"),
//                  @"109" : NSLocalizedString(@"current_device_not_support",@"当前设备不支持")
//                  
//                  };
//                
//                if([content isEqualToString:@"2000"]){
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"login_reminder", nil)
//                                                                    message:wrongMessage[content]
//                                                                   delegate:self
//                                                          cancelButtonTitle:NSLocalizedString(@"head_cancel", @"取消")
//                                                          otherButtonTitles:NSLocalizedString(@"login_conform_go_prepaid", @"去充值"), nil];
//                    alert.tag = 1998;
//                    [alert show];
//                    
//                }else{
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"login_reminder", nil)
//                                                                    message:wrongMessage[content]
//                                                                   delegate:self
//                                                          cancelButtonTitle:nil
//                                                          otherButtonTitles:NSLocalizedString(@"login_conform", @"确认"), nil];
//                    alert.tag = 1997;
//                    [alert show];
//                }
//            }
        }
  
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error:%@",error);
    }];
    

}

@end
