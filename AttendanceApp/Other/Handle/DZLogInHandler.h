//
//  DZLogInHandler.h
//  AttendanceApp
//
//  Created by 杜仲 on 2017/5/11.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "LLBaseHandler.h"

@interface DZLogInHandler : LLBaseHandler


#pragma mark - 登陆

+ (void)requestLogInWithParameters:(NSDictionary * _Nullable)parameters
                           Success:(_Nullable SuccessBlock)success
                           failure:(_Nullable FailedBlock)failure;


//updateApp
+ (void)requestUpdateAppWithParameters:(NSDictionary * _Nullable)parameters
                           Success:(_Nullable SuccessBlock)success
                           failure:(_Nullable FailedBlock)failure;

@end
