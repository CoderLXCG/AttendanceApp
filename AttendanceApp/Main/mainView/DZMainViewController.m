//
//  DZMainViewController.m
//  AttendanceApp
//
//  Created by 杜仲 on 2017/4/20.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "DZMainViewController.h"
#import "DZNavigationController.h"
#import "DZLoginViewController.h"
#import "GFCalendar.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeScanningVC.h"
#import "DZDayDetailViewController.h"
#import "DZAskForLeaveViewController.h"
#import "DZWorkOverTimeViewController.h"
#import "DZAskForLeaveHandle.h"
#import "DZLogInHandler.h"
#import "DZClockInHandler.h"
#import "DZActionSheet.h"
#import "DZClockListModel.h"
#import "DZLoginViewController.h"
#import "AppDelegate.h"
#import "ProgressHUD.h"

@interface DZMainViewController ()<AVCapturePhotoCaptureDelegate,AVCaptureMetadataOutputObjectsDelegate,DZActionSheetDelegate>

/// 会话对象
@property (nonatomic, strong) AVCaptureSession *session;
/// 图层类
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) UIButton * clockInButton;

@property (nonatomic, strong) UIButton * askForLeaveButton;

@property (nonatomic, strong) UIButton * workOvertimeButton;

@property (nonatomic, strong) UIButton * LogOutButton;

@property (nonatomic, strong) NSMutableArray * days;

@property (nonatomic, strong) DZActionSheet * actionSheet;

@property (nonatomic, assign) BOOL isSuccess; //判断网络请求是否成功

@property (nonatomic, copy) NSString * failedString;

@end

@implementation DZMainViewController

- (UIButton *)clockInButton
{
    if (!_clockInButton) {
        _clockInButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 400, (self.view.width - 120)/3.0, 30)];
        _clockInButton.layer.cornerRadius = 5;
        [_clockInButton setBackgroundImage:[UIImage imageNamed:@"btn_qd"] forState:UIControlStateNormal];
        [_clockInButton setTitle:@"签到" forState:UIControlStateNormal];
        [_clockInButton addTarget:self action:@selector(clockIn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clockInButton;
}

- (UIButton *)askForLeaveButton
{
    if (!_askForLeaveButton) {
        _askForLeaveButton = [[UIButton alloc] initWithFrame:CGRectMake(60 + (self.view.width - 120)/3.0, 400, (self.view.width - 120)/3.0, 30)];
        _askForLeaveButton.layer.cornerRadius = 5;
        [_askForLeaveButton setBackgroundImage:[UIImage imageNamed:@"btn_qd"] forState:UIControlStateNormal];
        [_askForLeaveButton setTitle:@"请假" forState:UIControlStateNormal];
        [_askForLeaveButton addTarget:self action:@selector(askForLeave) forControlEvents:UIControlEventTouchUpInside];
    }
    return _askForLeaveButton;
}

- (UIButton *)workOvertimeButton
{
    if (!_workOvertimeButton) {
        _workOvertimeButton = [[UIButton alloc] initWithFrame:CGRectMake(90 + (self.view.width - 120)/3.0 *2, 400, (self.view.width - 120)/3.0, 30)];
        _workOvertimeButton.layer.cornerRadius = 5;
        [_workOvertimeButton setBackgroundImage:[UIImage imageNamed:@"btn_qd"] forState:UIControlStateNormal];
        [_workOvertimeButton setTitle:@"加班" forState:UIControlStateNormal];
        [_workOvertimeButton addTarget:self action:@selector(workOvertime) forControlEvents:UIControlEventTouchUpInside];
    }
    return _workOvertimeButton;
}

- (UIButton *)LogOutButton
{
    if (!_LogOutButton) {
        _LogOutButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 450, self.view.width - 40, 30)];
        _LogOutButton.layer.cornerRadius = 5;
        [_LogOutButton setBackgroundImage:[UIImage imageNamed:@"btn_qd"] forState:UIControlStateNormal];
        [_LogOutButton setTitle:@"退出登陆" forState:UIControlStateNormal];
        [_LogOutButton addTarget:self action:@selector(LogOut) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LogOutButton;
}

- (NSMutableArray *)days
{
    if (!_days) {
        _days = [NSMutableArray arrayWithCapacity:0];
    }
    return _days;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    
    [self days];
    
    _isSuccess = YES;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    //获取当前月份请假记录  获取更新  获取打卡历史记录
    [self getNet];
    
}

- (void)getNet
{
    [ProgressHUD showHUDWithTitle:@"努力加载中..." view:self.view];
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getAskForLeaveRecord];
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getUpdateApp];
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getClockInRecord];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //  配置 Calendar 及按钮
        [self.view addSubview:self.clockInButton];
        [self.view addSubview:self.askForLeaveButton];
        [self.view addSubview:self.workOvertimeButton];
        [self.view addSubview:self.LogOutButton];
        [self setupCalendar];
        [ProgressHUD hideHUDWithView:self.view];
        
        if (!_isSuccess) {
            _actionSheet = [[DZActionSheet alloc] initWithTitle:_failedString
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"确定"
                                              otherButtonTitles:nil];
            _actionSheet.tag = 1002;
            [_actionSheet showInView:self.view];
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 网络请求
- (void)getAskForLeaveRecord
{
    //获取当前月份
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags =  NSCalendarUnitMonth;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    NSInteger iCurMonth = [components month];
    
    
    NSDictionary * dict = @{
                            @"month":[NSString stringWithFormat:@"%ld",(long)iCurMonth]
                            };
    
     dispatch_semaphore_t  sema = dispatch_semaphore_create(0);
    
    [DZAskForLeaveHandle requestGetLeaveRecordWithParameters:dict
                                                     Success:^(id obj) {
                                                         
                                                         WDLog(@"获取请假记录成功");
                                                         dispatch_semaphore_signal(sema);
                                                         
                                                     } failure:^(NSError *error) {
                                                         _isSuccess = NO;
                                                         _failedString = @"获取请假记录失败";
                                                         
                                                         dispatch_semaphore_signal(sema);
                                                     }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}


//获取app版本信息并判断是否要更新
- (void)getUpdateApp
{
    NSDictionary * dict = @{
                            @"version":@"1.0"
                           };
    
    dispatch_semaphore_t  sema = dispatch_semaphore_create(0);
    
    [DZLogInHandler requestUpdateAppWithParameters:dict
                                           Success:^(id obj) {
        
                                               WDLog(@"获取版本成功");
                                               dispatch_semaphore_signal(sema);
                                           } failure:^(NSError *error) {
        
                                               WDLog(@"获取版本失败");
                                               
                                               _isSuccess = NO;
                                               _failedString = @"获取版本失败";

                                               dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

- (void)getClockInRecord
{
    
    //获取当前月份
    NSDate * senddate=[NSDate date];
    NSCalendar * cal=[NSCalendar currentCalendar];
    NSUInteger unitFlags= NSCalendarUnitYear|NSCalendarUnitMonth;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];

    NSString * String= [NSString stringWithFormat:@"%4ld-%02ld",(long)year,month];
    
    NSDictionary * dict = @{@"month":String};
    
    dispatch_semaphore_t  sema = dispatch_semaphore_create(0);
    
    [DZClockInHandler requestClockHistoryRecordWithParameters:dict
                                                      Success:^(id obj) {
                                                          WDLog(@"请求打卡历史记录成功");
                                                          
                                                          NSArray * tempArr = obj[@"data"][@"list"];
                                                          
                                                          NSArray * array = [NSArray yy_modelArrayWithClass:[DZClockListModel class] json:tempArr];
                                                          
                                                          _days = [NSMutableArray arrayWithArray:array];
                                                          dispatch_semaphore_signal(sema);
                                                      } failure:^(NSError *error) {
                                                          dispatch_semaphore_signal(sema);
                                                          WDLog(@"获取打卡历史记录失败");
                                                          _isSuccess = NO;
                                                          _failedString = @"获取打卡历史记录失败";
    
                                                      }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

#pragma mark - 按钮点击事件
- (void)setupCalendar
{
    CGFloat width = self.view.bounds.size.width - 20.0;
    CGPoint origin = CGPointMake(10.0, 50);
    
    GFCalendarView *calendar = [[GFCalendarView alloc] initWithFrameOrigin:origin width:width days:_days];
    
    // 点击某一天的回调
    calendar.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
        
        DZDayDetailViewController *dayVc = [[DZDayDetailViewController alloc] init];
        
        dayVc.array = _days;
        dayVc.day = day;
        dayVc.title = [NSString stringWithFormat:@"%ld月%ld日", (long)month, day];
        [self.navigationController pushViewController:dayVc animated:YES];
        
    };
    
    [self.view addSubview:calendar];

}

- (void)clockIn
{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                    
                    SGQRCodeLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    SGQRCodeLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    SGQRCodeLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"⚠️ 警告" message:@"请去-> [设置 - 隐私 - 相机 - 考勤] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

- (void)askForLeave
{
    DZAskForLeaveViewController * askVc = [[DZAskForLeaveViewController alloc] init];
    askVc.title = @"请假申请";
    [self.navigationController pushViewController:askVc animated:YES];
}

- (void)workOvertime
{
    DZWorkOverTimeViewController * workOverVc = [[DZWorkOverTimeViewController alloc] init];
    workOverVc.title = @"加班申请";
    [self.navigationController pushViewController:workOverVc animated:YES];
}

- (void)LogOut
{ 
    _actionSheet = [[DZActionSheet alloc] initWithTitle:@"确定要退出登陆吗？"
                                               delegate:self
                                      cancelButtonTitle:@"取消"
                                 destructiveButtonTitle:@"确定"
                                      otherButtonTitles:nil];
    _actionSheet.tag = 1001;
    [_actionSheet showInView:self.view];
}

#pragma mark - DZActionSheetDelegate的方法
- (void)didClickOnDestructiveButton
{
    if (_actionSheet.tag == 1001) {
        //更改登录状态
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"isLogIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //推出登录控制器。 并让navigation不能返回。
        [self.navigationController popToRootViewControllerAnimated:NO];
        (((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController) = [[DZLoginViewController alloc] init];
        
    }else if (_actionSheet.tag == 1002) {
        [self getNet];
    }
}

- (void)didClickOnCancelButton
{
    if (_actionSheet.tag == 1002) {
        WDLog(@"不管了");
    }
}

@end
