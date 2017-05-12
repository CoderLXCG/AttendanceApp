//
//  DZAskForLeaveHandle.m
//  AttendanceApp
//
//  Created by 杜仲 on 2017/5/12.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "DZAskForLeaveHandle.h"
#import "LLURLHelper.h"

@implementation DZAskForLeaveHandle

//请假类型
+ (void)requestFindLeaveTypeWithParameters:(NSDictionary * _Nullable)parameters
                                   Success:(_Nullable SuccessBlock)success
                                   failure:(_Nullable FailedBlock)failure
{
    [[AFHttpClient sharedClient] requestAFHTTPSessionWithPath:[LLURLHelper geturl:kkFindLeaveType]
                                                       method:AFHttpRequestGet
                                                   parameters:parameters
                                               prepareExecute:nil
                                                      success:^(NSURLSessionDataTask *task, id responseObject){
                                                          
                                                          success(responseObject);
                                                          
                                                      } failure:^(NSURLSessionDataTask *task, NSError *error){
                                                          
                                                          failure(error);
                                                      }];

}


//请假
+ (void)requestLeaveApplyWithParameters:(NSDictionary * _Nullable)parameters
                                Success:(_Nullable SuccessBlock)success
                                failure:(_Nullable FailedBlock)failure
{
    [[AFHttpClient sharedClient] requestAFHTTPSessionWithPath:[LLURLHelper geturl:kkLeaveApply]
                                                       method:AFHttpRequestGet
                                                   parameters:parameters
                                               prepareExecute:nil
                                                      success:^(NSURLSessionDataTask *task, id responseObject){
                                                          
                                                          success(responseObject);
                                                          
                                                      } failure:^(NSURLSessionDataTask *task, NSError *error){
                                                          
                                                          failure(error);
                                                      }];

}



@end
