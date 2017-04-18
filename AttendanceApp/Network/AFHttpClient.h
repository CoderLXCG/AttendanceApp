//
//  AFHttpClinet.h
//  YingJieSheng
//
//  Created by Liu Lei on 12/23/14.
//  Copyright (c) 2014 ___Liu Lei___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "APIConfig.h"

/**
 *  HTTP REQUEST METHOD TYPE
 */
typedef NS_ENUM(NSInteger, RTHttpRequestType) {
    AFHttpRequestGet,
    AFHttpRequestPost,
    AFHttpRequestDelete,
    AFHttpRequestPut,
};

/**
 *  请求开始前预处理Block
 */
typedef void(^PrepareExecuteBlock)(void);


@interface AFHttpClient : NSObject

+ (AFHttpClient *)sharedClient;

/**
 *  NSURLSessionDataTask 请求（GET、POST、DELETE、PUT）
 */
- (void)requestAFHTTPSessionWithPath:(NSString *)url
                method:(NSInteger)method
            parameters:(id)parameters
        prepareExecute:(PrepareExecuteBlock) prepare
               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  HTTP请求（HEAD）
 */
- (void)requestWithPathInHEAD:(NSString *)url
                  parameters:(NSDictionary *)parameters
                     success:(void (^)(NSURLSessionDataTask *task))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  HTTP请求上传图片（POST）
 */
- (void)requestUploadWithAFHttpSession:(NSString *)url
                                method:(NSInteger)method
                            parameters:(id)parameters
                        prepareExecute:(PrepareExecuteBlock)prepareExecute
             constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//判断当前网络状态
- (BOOL)isConnectionAvailable;

@end
