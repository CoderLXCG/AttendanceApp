//
//  DZOverTimeHandle.h
//  AttendanceApp
//
//  Created by 杜仲 on 2017/5/15.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "LLBaseHandler.h"

@interface DZOverTimeHandle : LLBaseHandler


//加班申请
+ (void)requestOverTimeApplyWithParameters:(NSDictionary * _Nullable)parameters
                                   Success:(_Nullable SuccessBlock)success
                                   failure:(_Nullable FailedBlock)failure;

@end
