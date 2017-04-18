//
//  NotificationConsts.h
//  YingJieSheng
//
//  Created by Liu Lei on 12/24/14.
//  Copyright (c) 2014 ___Liu Lei___. All rights reserved.
// 1

#ifndef YingJieSheng_NotificationConsts_h
#define YingJieSheng_NotificationConsts_h

#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
//通知
#define kNotificationFitstRun @"kNotificationFitstRun"

//创建动态键盘收回通知
#define kkNotification_FeedContentKey     @"FeedContentKey"

//网络异常通知
#define kkNotification_NetworkError    @"kkNotification_NetworkError"

//连接超时通知
#define kkNotification_NoLogin     @"kkNotification_NoLogin"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


#define     HTTP_STATUS_SUCCESS         1	//返回成功
#define     HTTP_STATUS_FAILED          0	//返回异常
//#define     HTTP_STATUS_FAILED          -1	//返回失败
#define     HTTP_STATUS_ERROR           -1//返回错误
#define     HTTP_STATUS_NOTFUND         404	//未找到
#define     HTTP_STATUS_NOPERMISSION    502	//无权限

#endif
