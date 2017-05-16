//
//  APIConfig.h
//
//  Created by Liu Lei on 12/23/14.
//  Copyright (c) 2014 ___Liu Lei___. All rights reserved.
//

#import <UIKit/UIKit.h>


//测试服务器
#define kkBase_url  @"http://10.0.0.36:8085/attendance/attAppAction/" //杨明兴的数据库
//#define kkBase_url  @"http://10.0.0.142:8080/attendance/attAppAction/"


/**
 * 接口索引
 */
#define kkLogIn                      1001               //登陆
#define kkUpdateApp                  1002               //更新
#define kkFindLeaveType              1003               //请假类型
#define kkLeaveApply                 1004               //请假
#define kkOverTimeApply              1005               //加班
#define kkGetLeaveRecord             1006               //请假记录
#define kkClockIn                    1007               //打卡签到
#define kkClockInHistory             1008               //打卡记录


@interface APIConfig : NSObject

@end
