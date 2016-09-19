//
//  TTUserModel.h
//  TourTalklib
//
//  Created by apple on 16/9/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTUserModel : NSObject
@property (nonatomic, copy)NSString *account;/**< 账号 */
@property (nonatomic, copy)NSString *customerId;/**< 用户ID */
@property (nonatomic, copy)NSString *experience;/**< 经验值 */
@property (nonatomic, copy)NSString *gold;/**< 金币 */
@property (nonatomic, copy)NSString *headUrl;/**< 头像 */
@property (nonatomic, copy)NSString *nickname;/**< 昵称 */
@property (nonatomic, copy)NSString *phone;/**< 手机号 */
@end
