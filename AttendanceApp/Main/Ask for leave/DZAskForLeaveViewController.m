//
//  DZAskForLeaveViewController.m
//  AttendanceApp
//
//  Created by 杜仲 on 2017/4/21.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "DZAskForLeaveViewController.h"
#import "LXActionSheet.h"

@interface DZAskForLeaveViewController ()<UITextViewDelegate,UITextFieldDelegate,LXActionSheetDelegate>
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

@property (nonatomic, strong) LXActionSheet * actionSheet;

@end

@implementation DZAskForLeaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    picker.datePickerMode = UIDatePickerModeDateAndTime;
    [picker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
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
    
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 60, 30)];
    _typeLabel.font = [UIFont systemFontOfSize:14];
    _typeLabel.text = @"请假类型";
    [self.view addSubview:_typeLabel];
    
    _reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 60, 30)];
    _reasonLabel.font = [UIFont systemFontOfSize:14];
    _reasonLabel.text = @"请假原因";
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
    
    _typeTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, self.view.width - 120, 30)];
    _typeTextField.delegate = self;
    _typeTextField.backgroundColor = UIColorFromRGB(0xeeeeee);
    _typeTextField.tag = 1002;
    _typeTextField.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_typeTextField];
    
    _reasonTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 230, self.view.width - 40, 120)];
    _reasonTextView.delegate = self;
    _reasonTextView.backgroundColor = UIColorFromRGB(0xeeeeee);
    _reasonTextView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_reasonTextView];
    
    _defineButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 44 - 64, self.view.width, 44)];
    [_defineButton setBackgroundImage:[UIImage imageNamed:@"btn_qd"] forState:UIControlStateNormal];
    [_defineButton setTitle:@"确定" forState:UIControlStateNormal];
    [_defineButton addTarget:self action:@selector(askForLeave) forControlEvents:UIControlEventTouchUpInside];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1002) {
        _actionSheet = [[LXActionSheet alloc] initWithTitle:@"请假类型" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@[@"事假",@"病假",@"出差",@"其他"]];
        [_actionSheet showInView:self.view];
        return NO;
    }else
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)TextField {
    if (TextField.tag == 1002) {
        [TextField resignFirstResponder];
    }
    return YES;
}

- (void)pickerValueChanged:(UIDatePicker *)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-MM"];
    self.currentDateTextField.text = [formatter stringFromDate:sender.date];
}

- (void)askForLeave
{
    //发送请假请求
}

#pragma mark - LxactionSheetDelegate
- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex
{
    int number = (int)buttonIndex;
    if (buttonIndex == 0) {
        _typeTextField.text = @"事假";
    }else if(number == 1) {
        _typeTextField.text = @"病假";
    }else if (number == 2) {
        _typeTextField.text = @"出差";
    }else if (number == 3) {
        _typeTextField.text = @"其他";
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
