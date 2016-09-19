//
//  TTUserMessageManager.h
//  TourTalklib
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TTUserBlock)(id result);

/**
 *  TourTalk用户信息管理
 */
@interface TTUserMessageManager : NSObject

/**
 *  TourTalk用户登录
 *
 *  @param UserNum      用户账号
 *  @param UserPassWord 用户密码
 *  @param block        执行结果回调block
 */
+ (void)TTUserLoginAction:(NSString *)UserNum
             UserPassWord:(NSString *)UserPassWord
                    block:(TTUserBlock)block;

/**
 *  TourTalk用户退出登录
 *
 *  @param block 执行结果回调block
 */
+ (void)TTUserOutLoginAction:(TTUserBlock)block;


/**
 *  TourTalk用户注册
 *
 *  @param UserNum      用户账号
 *  @param inviteCode   用户邀请码
 *  @param UserPassWord 用户密码
 *  @param UserNickName 用户昵称
 *  @param block        执行结果回调block
 */
+ (void)TTUserResgisterAction:(NSString *)UserNum
                   inviteCode:(NSString *)inviteCode
                 UserPassWord:(NSString *)UserPassWord
                 UserNickName:(NSString *)UserNickName
                        block:(TTUserBlock)block;


@end
