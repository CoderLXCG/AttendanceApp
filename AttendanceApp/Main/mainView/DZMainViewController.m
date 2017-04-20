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
#import "DZDayDetailViewController.h"
#import "DZClockInViewController.h"

@interface DZMainViewController ()

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
        _days = [NSMutableArray arrayWithCapacity:0];
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
    DZClockInViewController * clockVc = [[DZClockInViewController alloc] init];
    [self.navigationController pushViewController:clockVc animated:YES];
}

- (void)askForLeave
{
}

- (void)workOvertime
{
}

@end
