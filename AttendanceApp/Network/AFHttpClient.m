//
//  AFHttpClinet.m
//  YingJieSheng
//
//  Created by Liu Lei on 12/23/14.
//  Copyright (c) 2014 ___Liu Lei___. All rights reserved.
//

#import "AFHttpClient.h"
#import "Reachability.h"
#import "NotificationConsts.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>

@interface AFHttpClient()

@end

@implementation AFHttpClient

- (id)init{
    if (self = [super init]){
    }
    return self;
}

+ (AFHttpClient *)sharedClient{
    static AFHttpClient *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

static AFHTTPSessionManager *manager;

+ (AFHTTPSessionManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化请求管理类
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kkBase_url]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 15.0f;
        manager.requestSerializer  = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"x-device-id"];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    });
    return manager;
}


//看看网络是不是给力
- (BOOL)isConnectionAvailable{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        NSLog(@"网络不给力,请检查网络设置");
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}


- (void)requestAFHTTPSessionWithPath:(NSString *)url
                       method:(NSInteger)method
                   parameters:(id)parameters
               prepareExecute:(PrepareExecuteBlock)prepareExecute
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure

{
    AFHTTPSessionManager *manager = [AFHttpClient sharedManager];
    
    //拼接参数字典
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [dict setValue:@"app" forKeyPath:@"scope"];
    [dict setValue:kkAppVersion forKeyPath:@"app_version"];
    [dict setValue:@"iOS" forKeyPath:@"device_platform"];
    
    //判断网络状况（有链接：执行请求；无链接：弹出提示）
    if ([self isConnectionAvailable]) {
        //预处理（显示加载信息啥的）
        if (prepareExecute) {
            prepareExecute();
        }
        switch (method) {
            case AFHttpRequestGet:
            {
                [manager GET:url parameters:dict progress:nil success:success failure:failure];
            }
                break;
            case AFHttpRequestPost:
            {
                [manager POST:url parameters:dict progress:nil success:success failure:failure];
            }
                break;
            case AFHttpRequestDelete:
            {
                [manager DELETE:url parameters:dict success:success failure:failure];
            }
                break;
            case AFHttpRequestPut:
            {
                [manager PUT:url parameters:dict success:success failure:failure];
            }
                break;
            default:
                break;
        }
    }else{
        
        //发出网络异常通知广播
        [[NSNotificationCenter defaultCenter] postNotificationName:kkNotification_NetworkError object:nil];
        if (failure) {
            failure(nil, nil);
        }
    }
    
}
/*
- (void)requestAFhttpWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters prepareExecute:(PrepareExecuteBlock)prepareExecute
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    //判断网络状况（有链接：执行请求；无链接：弹出提示）
    if ([self isConnectionAvailable]) {
        //预处理（显示加载信息啥的）
        if (prepareExecute) {
            prepareExecute();
        }
        switch (method) {
            case AFHttpRequestGet:
            {
                [manager GET:url parameters:parameters success:success failure:failure];
            }
                break;
            case AFHttpRequestPost:
            {
                [manager POST:url parameters:parameters success:success failure:failure];
            }
                break;
            case AFHttpRequestDelete:
            {
                [manager DELETE:url parameters:parameters success:success failure:failure];
            }
                break;
            case AFHttpRequestPut:
            {
                [manager PUT:url parameters:parameters success:success failure:false];
            }
                break;
            default:
                break;
        }
    }else{

        //发出网络异常通知广播
        [[NSNotificationCenter defaultCenter] postNotificationName:kkNotification_NetworkError object:nil];
    }

}
*/

- (void)requestWithPathInHEAD:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kkBase_url]];

    //设置相应内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    if ([self isConnectionAvailable]) {
        [manager HEAD:url parameters:parameters success:success failure:failure];
    }else{
        //发出网络异常通知广播
        [[NSNotificationCenter defaultCenter] postNotificationName:kkNotification_NetworkError object:nil];
    }
}


- (void)requestUploadWithAFHttpSession:(NSString *)url
                                method:(NSInteger)method
                            parameters:(id)parameters
                        prepareExecute:(PrepareExecuteBlock)prepareExecute
             constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kkBase_url]];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //判断网络状况（有链接：执行请求；无链接：弹出提示）
    if ([self isConnectionAvailable]) {
        //预处理（显示加载信息啥的）
        if (prepareExecute) {
            prepareExecute();
        }
        switch (method) {
            case AFHttpRequestPost:
            {
                [manager POST:url
                   parameters:parameters
    constructingBodyWithBlock:block
                     progress:nil
                      success:success failure:failure];
//                [manager POST:url
//                   parameters:parameters
//    constructingBodyWithBlock:block
//                      success:success
//                      failure:failure];
            }
                break;
            default:
                break;
        }
    }else{
        //发出网络异常通知广播
        [[NSNotificationCenter defaultCenter] postNotificationName:kkNotification_NetworkError object:nil];
    }
}


@end
