//
//  DZDayDetailViewController.m
//  AttendanceApp
//
//  Created by 杜仲 on 2017/4/20.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "DZDayDetailViewController.h"

#define FONT 16
@interface DZDayDetailViewController ()

@property (nonatomic, strong) UILabel * startLabel;
@property (nonatomic, strong) UILabel * endLabel;
@property (nonatomic, strong) UILabel * startTimeLabel;
@property (nonatomic, strong) UILabel * endTimeLabel;
@property (nonatomic, strong) UILabel * askForLeaveLabel;
@property (nonatomic, strong) UILabel * askForLeaveTimeLabel;

@end

@implementation DZDayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _startLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 120, 30)];
    _startLabel.font = [UIFont systemFontOfSize:FONT];
    _startLabel.text = @"上班打卡时间 :";
    [self.view addSubview:_startLabel];
    
    _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 120, 30)];
    _endLabel.font = [UIFont systemFontOfSize:FONT];
    _endLabel.text = @"下班打卡时间 :";
    [self.view addSubview:_endLabel];
    
    
    
    
    _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 50, 150, 30)];
    _endLabel.font = [UIFont systemFontOfSize:FONT];
    _endLabel.text = @"9:07";
    [self.view addSubview:_endLabel];
    
    _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, 150, 30)];
    _endLabel.font = [UIFont systemFontOfSize:FONT];
    _endLabel.text = @"18:00";
    [self.view addSubview:_endLabel];
    
    
    
    _askForLeaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 120, 30)];
    _askForLeaveLabel.font = [UIFont systemFontOfSize:FONT];
    _askForLeaveLabel.text = @"请假时间:";
    [self.view addSubview:_askForLeaveLabel];
    
    _askForLeaveTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 150, 150, 30)];
    _askForLeaveTimeLabel.font = [UIFont systemFontOfSize:FONT];
    _askForLeaveTimeLabel.text = @"9:00 - 12:00";
    [self.view addSubview:_askForLeaveTimeLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
