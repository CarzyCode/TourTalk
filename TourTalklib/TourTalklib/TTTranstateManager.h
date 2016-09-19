//
//  TTTranstateManager.h
//  TourTalklib
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TTTranstateBlock)(id result);
/**
 *  TourTalk翻译请求
 */
@interface TTTranstateManager : NSObject


/**
 *  TourTalk 翻译
 *
 *  @param sourceLanguage 源语言
 *  @param language       目标语言
 *  @param talkType       1 - 语音  2 - 视频
 *  @param block          执行结果回调block
 */
+ (void)TTTranstate:(NSString *)sourceLanguage
           language:(NSString *)language
           talkType:(NSString *)talkType
              block:(TTTranstateBlock)block;
/**
 *  TourTalk 翻译取消
 *
 *  @param orderNo 订单号
 *  @param block          执行结果回调block
 */
+ (void)TTTranstateCancel:(NSString *)orderNo
                    block:(TTTranstateBlock)block;

@end
