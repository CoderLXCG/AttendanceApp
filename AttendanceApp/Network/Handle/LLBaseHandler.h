//
//  LLBaseHandler.h
//  YingJieSheng
//
//  Created by Liu Lei on 12/23/14.
//  Copyright (c) 2014 ___Liu Lei___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHttpClient.h"
#import "NotificationConsts.h"

/**
 *  Handler处理完成后调用的Block
 */
typedef void (^CompleteBlock)();


/**
 *  Handler处理成功时调用的Block
 */
typedef void (^SuccessBlock)(id obj);
typedef void (^Success)(NSArray *array);


/**
 *  Handler处理失败时调用的Block
 */
typedef void (^FailedBlock)(NSError *error);
typedef void (^Failure)(NSError *error);


@interface LLBaseHandler : NSObject


@end
