//
//  DZLogInHandler.m
//  AttendanceApp
//
//  Created by 杜仲 on 2017/5/11.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "DZLogInHandler.h"
#import "LLURLHelper.h"

@implementation DZLogInHandler

/**
 *  注册创建用户业务逻辑处理
 */
+ (void)requestLogInWithParameters:(NSDictionary *)parameters
                           Success:(_Nullable SuccessBlock)success
                           failure:(_Nullable FailedBlock)failure
{
    
    [[AFHttpClient sharedClient] requestAFHTTPSessionWithPath:[LLURLHelper geturl:kkLogIn]
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
