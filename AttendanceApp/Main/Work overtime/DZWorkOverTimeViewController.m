//
//  DZWorkOverTimeViewController.m
//  AttendanceApp
//
//  Created by 杜仲 on 2017/4/21.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "DZWorkOverTimeViewController.h"
#import "DZOverTimeHandle.h"
#import "DZActionSheet.h"

@interface DZWorkOverTimeViewController ()<UITextViewDelegate,UITextFieldDelegate,DZActionSheetDelegate>

@property (nonatomic, strong) UILabel * startLabel;

@property (nonatomic, strong) UILabel * endLabel;

@property (nonatomic, strong) UILabel * typeLabel;

@property (nonatomic, strong) UILabel * reasonLabel;

@property (nonatomic, strong) UITextField * startTextfield;

@property (nonatomic, strong) UITextField * endTextField;

@property (nonatomic, strong) UITextField * typeTextField;

@property (nonatomic, strong) UITextView * reasonTextView;

@property (nonatomic, strong) UITextField * currentDateTextField;

@property (nonatomic, strong) UIButton * defineButton;

@property (nonatomic, strong) DZActionSheet * actonSheet;

@end

@implementation DZWorkOverTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    picker.datePickerMode = UIDatePickerModeDateAndTime;
    [picker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
    [picker addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.startTextfield.inputView = picker;
    self.endTextField.inputView = picker;
    
}

- (void)setupUI
{
    _startLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 60, 30)];
    _startLabel.font = [UIFont systemFontOfSize:14];
    _startLabel.text = @"开始时间";
    [self.view addSubview:_startLabel];
    
    _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 60, 30)];
    _endLabel.font = [UIFont systemFontOfSize:14];
    _endLabel.text = @"结束时间";
    [self.view addSubview:_endLabel];
    
    _reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 60, 30)];
    _reasonLabel.font = [UIFont systemFontOfSize:14];
    _reasonLabel.text = @"加班内容";
    [self.view addSubview:_reasonLabel];
    
    _startTextfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 50, self.view.width - 120, 30)];
    _startTextfield.delegate = self;
    _startTextfield.backgroundColor = UIColorFromRGB(0xeeeeee);
    _startTextfield.tag = 1000;
    _startTextfield.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_startTextfield];
    
    _endTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, self.view.width - 120, 30)];
    _endTextField.delegate = self;
    _endTextField.backgroundColor = UIColorFromRGB(0xeeeeee);
    _endTextField.tag = 1001;
    _endTextField.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_endTextField];
    
    
    _reasonTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 180, self.view.width - 40, 120)];
    _reasonTextView.delegate = self;
    _reasonTextView.backgroundColor = UIColorFromRGB(0xeeeeee);
    _reasonTextView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_reasonTextView];
    
    _defineButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 44 - 64, self.view.width, 44)];
    [_defineButton setBackgroundImage:[UIImage imageNamed:@"btn_qd"] forState:UIControlStateNormal];
    [_defineButton setTitle:@"确定" forState:UIControlStateNormal];
    [_defineButton addTarget:self action:@selector(askForWorkOverTime) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_defineButton];
}


#pragma mark - textfield 代理事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    if (textField == self.startTextfield ||
    //        textField == self.endTextField)
    //    {
    //        self.currentDateTextField = textField;
    //    }
    self.currentDateTextField = textField;
}


- (void)pickerValueChanged:(UIDatePicker *)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    self.currentDateTextField.text = [formatter stringFromDate:sender.date];
}

- (void)askForWorkOverTime
{
    

    
    //发送加班请求
    NSDictionary * dict = @{
                            @"startTime":_startTextfield.text,
                            @"endTime":_endTextField.text,
                            @"content":_reasonTextView.text
                            };
    
    [DZOverTimeHandle requestOverTimeApplyWithParameters:dict
                                                 Success:^(id obj) {
                                                     if ([obj[@"status"] integerValue] == 1) {
                                                         WDLog(@"加班申请成功");
                                                         [self.navigationController popViewControllerAnimated:YES];
                                                     }
                                                 } failure:^(NSError *error) {
        
                                                     WDLog(@"加班申请失败");
                                                     
                                                     _actonSheet = [[DZActionSheet alloc] initWithTitle:@"加班申请失败"
                                                                                               delegate:self
                                                                                      cancelButtonTitle:nil
                                                                                 destructiveButtonTitle:@"确定"
                                                                                      otherButtonTitles:nil];
                                                     _actonSheet.tag = 1002;
                                                     [_actonSheet showInView:self.view];
    
                                                 }];
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSTimeInterval animationDuration = 0.1f;
    
    [UIView beginAnimations:@"changeKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame = CGRectMake(0, -30, self.view.width, self.view.height);
    
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSTimeInterval animationDuration = 0.1f;
    
    [UIView beginAnimations:@"changeKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame = CGRectMake(0, 64, self.view.width, self.view.height);
    
    [UIView commitAnimations];
}

#pragma mark - DZActionSheetDelegate
- (void)didClickOnDestructiveButton
{
    if (_actonSheet.tag == 1002) {
        WDLog(@"知道了");
    }
}

@end
