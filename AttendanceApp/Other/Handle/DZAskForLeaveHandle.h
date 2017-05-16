//
//  DZAskForLeaveHandle.h
//  AttendanceApp
//
//  Created by 杜仲 on 2017/5/12.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "LLBaseHandler.h"

@interface DZAskForLeaveHandle : LLBaseHandler

//请假类型
+ (void)requestFindLeaveTypeWithParameters:(NSDictionary * _Nullable)parameters
                                   Success:(_Nullable SuccessBlock)success
                                   failure:(_Nullable FailedBlock)failure;


//请假
+ (void)requestLeaveApplyWithParameters:(NSDictionary * _Nullable)parameters
                                Success:(_Nullable SuccessBlock)success
                                failure:(_Nullable FailedBlock)failure;

//请假记录getLeaveRecord
+ (void)requestGetLeaveRecordWithParameters:(NSDictionary * _Nullable)parameters
                                    Success:(_Nullable SuccessBlock)success
                                    failure:(_Nullable FailedBlock)failure;

@end
