//
//  TTOrderMessageManager.h
//  TourTalklib
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTOrderModel.h"
/**
 *  订单信息管理
 */
@interface TTTranstateOrderManager : NSObject
/**
 @brief 单例
 @discussion 获取该类单例进行操作
 @return 返回类实例
 */
+ (TTTranstateOrderManager*)shareTTOrder;
/**
 *  获取订单列表
 *
 *  @param page 页码
 *  @param row  每页显示记录数
 *
 *  @return 订单数组
 */
- (NSArray *)GetOrderList:(NSString *)page
                         :(NSString *)row;
/**
 *  获取订单详情
 *
 *  @param orderId 订单ID
 *
 *  @return 订单信息model
 */
- (TTOrderModel *)GetOrderDetail:(NSString *)orderId;
@end
