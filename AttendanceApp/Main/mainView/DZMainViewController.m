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

@interface DZMainViewController ()<AVCapturePhotoCaptureDelegate,AVCaptureMetadataOutputObjectsDelegate>

/// 会话对象
@property (nonatomic, strong) AVCaptureSession *session;
/// 图层类
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) UIButton * clockInButton;

@property (nonatomic, strong) UIButton * askForLeaveButton;

@property (nonatomic, strong) UIButton * workOvertimeButton;

@property (nonatomic, strong) NSMutableArray * days;

@end

@implementation DZMainViewController

- (UIButton *)clockInButton
{
    if (!_clockInButton) {
        _clockInButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, (self.view.width - 120)/3.0, 30)];
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
        _askForLeaveButton = [[UIButton alloc] initWithFrame:CGRectMake(50 + (self.view.width - 120)/3.0, 400, (self.view.width - 120)/3.0, 30)];
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
        _workOvertimeButton = [[UIButton alloc] initWithFrame:CGRectMake(80 + (self.view.width - 120)/3.0 *2, 400, (self.view.width - 120)/3.0, 30)];
        _workOvertimeButton.layer.cornerRadius = 5;
        [_workOvertimeButton setBackgroundImage:[UIImage imageNamed:@"btn_qd"] forState:UIControlStateNormal];
        [_workOvertimeButton setTitle:@"加班" forState:UIControlStateNormal];
        [_workOvertimeButton addTarget:self action:@selector(workOvertime) forControlEvents:UIControlEventTouchUpInside];
    }
    return _workOvertimeButton;
}

- (NSMutableArray *)days
{
    if (!_days) {
//        _days = [NSMutableArray arrayWithCapacity:0];
        _days = [NSMutableArray arrayWithArray:@[@{@"12":@[@"9:10",@"18:20",@"9:20"]},
                                                 @{@"13":@[@"9:10",@"18:20",@"9:20"]},
                                                 @{@"19":@[@"9:10",@"18:20",@"9:20"]},
                                                 @{@"20":@[@"9:10",@"18:20",@"9:20"]}
                                                 ]];
    }
    return _days;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人主页";
    
    [self days];
    [self.view addSubview:self.clockInButton];
    [self.view addSubview:self.askForLeaveButton];
    [self.view addSubview:self.workOvertimeButton];
    [self setupCalendar]; //  配置 Calendar
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        dayVc.title = [NSString stringWithFormat:@"%ld月%ld日", month, day];
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

@end
