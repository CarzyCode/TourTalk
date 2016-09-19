//
//  TTAppKey.m
//  TourTalklib
//
//  Created by apple on 16/9/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TTAppKey.h"

@implementation TTAppKey

+ (TTAppKey *)shareTTUser
{
    static TTAppKey *TTAppKeyInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        TTAppKeyInstance = [[self alloc] init];
    });
    return TTAppKeyInstance;
}



@end
