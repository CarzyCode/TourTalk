//
//  TTHttpNetworkingRequset.h
//  TourTalklib
//
//  Created by apple on 16/9/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AppToolBlock)(id result);

@interface TTHttpNetworkingRequset : NSObject

+ (void)getDataWithURL:(NSString *)urlStr block:(AppToolBlock)block;

+ (void)postDataWithURL:(NSString *)urlStr  parameters:(id)parameters block:(AppToolBlock)block;

@end
