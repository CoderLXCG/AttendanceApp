//
//  LLURLHelper.m
//  YingJieSheng
//
//  Created by Liu Lei on 12/23/14.
//  Copyright (c) 2014 ___Liu Lei___. All rights reserved.
//

#import "LLURLHelper.h"

@implementation LLURLHelper

+ (NSString *)geturl:(NSInteger) did{

#ifdef DEBUG
    NSString *strBase = kkBase_url;
#else
    NSString *strBase = kkBase_url;
#endif
    switch (did) {
            
        case kkLogIn://用户注册
            return [strBase stringByAppendingString:@"userLogin.action"];
        case kkUpdateApp: //更新
            return [strBase stringByAppendingString:@"updateApp.action"];
        case kkFindLeaveType: //请假类型
            return [strBase stringByAppendingString:@"findLeaveType.action"];
        case kkLeaveApply:  //请假
            return [strBase stringByAppendingString:@"leaveApply.action"];
        case kkOverTimeApply: //加班申请
            return [strBase stringByAppendingString:@"overtimeApply.action"];
        case kkGetLeaveRecord: //请假记录
            return [strBase stringByAppendingString:@"getLeaveRecord.action"];
        case kkClockIn:  //打卡
            return [strBase stringByAppendingString:@"clockIn.action"];
        case kkClockInHistory: //打卡记录
            return [strBase stringByAppendingString:@"getClockHistoryRecord.action"];
 
            
    }
    return nil;
}

@end
