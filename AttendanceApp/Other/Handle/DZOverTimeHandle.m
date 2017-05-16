//
//  DZOverTimeHandle.m
//  AttendanceApp
//
//  Created by 杜仲 on 2017/5/15.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "DZOverTimeHandle.h"
#import "LLURLHelper.h"

@implementation DZOverTimeHandle


//加班申请
+ (void)requestOverTimeApplyWithParameters:(NSDictionary * _Nullable)parameters
                                   Success:(_Nullable SuccessBlock)success
                                   failure:(_Nullable FailedBlock)failure
{
    [[AFHttpClient sharedClient] requestAFHTTPSessionWithPath:[LLURLHelper geturl:kkOverTimeApply]
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
