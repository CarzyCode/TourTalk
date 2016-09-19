//
//  HttpJsonManager.h
//  VPImageCropperDemo
//
//  Created by 范宇 on 14/11/25.
//  Copyright (c) 2014年 Vinson.D.Warm. All rights reserved.
//

#import "AFNetworking.h"
//#import "Reachability.h"
@interface HttpJsonManager : AFHTTPRequestOperationManager

 + (void)postWithParameters:(NSDictionary *)params
                      url:(NSString *)url
                isEncrypt:(NSString *)Encrypt
        completionHandler:(void (^)(BOOL sucess, id content))completion;

@end
