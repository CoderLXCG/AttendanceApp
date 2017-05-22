//
//  DZDayDetailViewController.m
//  AttendanceApp
//
//  Created by 杜仲 on 2017/4/20.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "DZDayDetailViewController.h"
#import "DZClockListModel.h"

#define FONT 16
@interface DZDayDetailViewController ()

@property (nonatomic, strong) UILabel * startLabel;
@property (nonatomic, strong) UILabel * endLabel;
@property (nonatomic, strong) UILabel * startTimeLabel;
@property (nonatomic, strong) UILabel * endTimeLabel;
@property (nonatomic, strong) UILabel * askForLeaveLabel;
@property (nonatomic, strong) UILabel * askForLeaveTimeLabel;

@property (nonatomic, copy) NSString * startTime;
@property (nonatomic, copy) NSString * endTime;

@end

@implementation DZDayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (DZClockListModel * model in _array) {
        if ([[model.date substringWithRange:NSMakeRange(8, 2)] integerValue] == _day) {
            _startTime = model.startTime;
            _endTime = model.endTime;
        }
    }
    
    _startLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 120, 30)];
    _startLabel.font = [UIFont systemFontOfSize:FONT];
    _startLabel.text = @"上班打卡时间 :";
    [self.view addSubview:_startLabel];
    
    _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 120, 30)];
    _endLabel.font = [UIFont systemFontOfSize:FONT];
    _endLabel.text = @"下班打卡时间 :";
    [self.view addSubview:_endLabel];
    
    
    
    
    _startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 50, self.view.width - 150, 30)];
    _startTimeLabel.font = [UIFont systemFontOfSize:FONT];
    _startTimeLabel.text = _startTime?_startTime:@"";
    [self.view addSubview:_startTimeLabel];
    
    _endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, self.view.width - 150, 30)];
    _endTimeLabel.font = [UIFont systemFontOfSize:FONT];
    _endTimeLabel.text = _endTime?_endTime:@"";
    [self.view addSubview:_endTimeLabel];
    
    
    
    _askForLeaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 120, 30)];
    _askForLeaveLabel.font = [UIFont systemFontOfSize:FONT];
    _askForLeaveLabel.text = @"请假时间:";
    [self.view addSubview:_askForLeaveLabel];
    
    _askForLeaveTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 150, self.view.width - 150, 30)];
    _askForLeaveTimeLabel.font = [UIFont systemFontOfSize:FONT];
    _askForLeaveTimeLabel.text = @"";
    [self.view addSubview:_askForLeaveTimeLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
