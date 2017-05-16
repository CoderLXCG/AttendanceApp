//
//  DZClockInHandler.m
//  AttendanceApp
//
//  Created by 杜仲 on 2017/5/15.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "DZClockInHandler.h"
#import "LLURLHelper.h"

@implementation DZClockInHandler

//打卡签到
+ (void)requestClockInWithParameters:(NSDictionary * _Nullable)parameters
                             Success:(_Nullable SuccessBlock)success
                             failure:(_Nullable FailedBlock)failure
{
    [[AFHttpClient sharedClient] requestAFHTTPSessionWithPath:[LLURLHelper geturl:kkClockIn]
                                                       method:AFHttpRequestGet
                                                   parameters:parameters
                                               prepareExecute:nil
                                                      success:^(NSURLSessionDataTask *task, id responseObject){
                                                          
                                                          success(responseObject);
                                                          
                                                      } failure:^(NSURLSessionDataTask *task, NSError *error){
                                                          
                                                          failure(error);
                                                      }];
    

}

//打卡记录
+ (void)requestClockHistoryRecordWithParameters:(NSDictionary * _Nullable)parameters
                                        Success:(_Nullable SuccessBlock)success
                                        failure:(_Nullable FailedBlock)failure
{
    [[AFHttpClient sharedClient] requestAFHTTPSessionWithPath:[LLURLHelper geturl:kkClockInHistory]
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
