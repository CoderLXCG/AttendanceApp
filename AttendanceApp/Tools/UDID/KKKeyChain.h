//
//  KKKeyChain.h
//  AttendanceApp
//
//  Created by 杜仲 on 2017/5/11.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKKeyChain : NSObject
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service ;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;
@end
