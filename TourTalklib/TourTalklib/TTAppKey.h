//
//  TTAppKey.h
//  TourTalklib
//
//  Created by apple on 16/9/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  APPkey值
 */
@interface TTAppKey : NSObject
/**
 @brief 单例
 @discussion 获取该类单例进行操作
 @return 返回类实例
 */
+ (TTAppKey *)shareTTKey;

+ (void)seyAppKey:(NSString *)TTAppKey;
@end
