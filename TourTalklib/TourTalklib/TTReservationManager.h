//
//  TTReservationManager.h
//  TourTalklib
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TTReservationBlock)(id result);
/**
 *  TourTalk 预订服务请求
 */
@interface TTReservationManager : NSObject

/**
 *  预订服务
 *
 *  @param userLanguage 用户语言
 *  @param type         预约类型  2-约车  3-订餐
 *  @param block        执行结果回调block
 */
+ (void)TTReservation:(NSString *)userLanguage
                 type:(NSString *)type
                block:(TTReservationBlock)block;

@end
