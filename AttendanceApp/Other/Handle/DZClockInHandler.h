//
//  DZClockInHandler.h
//  AttendanceApp
//
//  Created by 杜仲 on 2017/5/15.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "LLBaseHandler.h"

@interface DZClockInHandler : LLBaseHandler

//打卡签到
+ (void)requestClockInWithParameters:(NSDictionary * _Nullable)parameters
                                   Success:(_Nullable SuccessBlock)success
                                   failure:(_Nullable FailedBlock)failure;

//打卡记录
+ (void)requestClockHistoryRecordWithParameters:(NSDictionary * _Nullable)parameters
                                        Success:(_Nullable SuccessBlock)success
                                        failure:(_Nullable FailedBlock)failure;

@end
