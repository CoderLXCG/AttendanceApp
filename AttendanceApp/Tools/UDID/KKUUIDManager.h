//
//  KKUUIDManager.h
//  AttendanceApp
//
//  Created by 杜仲 on 2017/5/11.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface KKUUIDManager : NSObject
+(void)saveUUID:(NSString *)uuid;

+(id)readUUID;

+(void)deleteUUID;
@end
