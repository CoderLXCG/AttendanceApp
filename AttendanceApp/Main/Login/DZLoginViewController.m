//
//  DZLoginViewController.m
//  AttendanceApp
//
//  Created by 杜仲 on 2017/4/20.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "DZLoginViewController.h"
#import "LXActionSheet.h"
#import "DZMainViewController.h"
#import "DZNavigationController.h"

@interface DZLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * tfAccount;

@property (nonatomic, strong) UITextField * tfPassword;

@property (nonatomic, strong) UIButton * logInButton;

@end

@implementation DZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"网丁考勤";
    
    [self tfAccount];
    [self tfPassword];
    [self logInButton];
    
}

- (UITextField *)tfAccount
{
    if (!_tfAccount) {
        _tfAccount = [[UITextField alloc] initWithFrame:CGRectMake(50, 150, self.view.width - 100, 30)];
        _tfAccount.backgroundColor = UIColorFromRGB(0xeeeeee);
        _tfAccount.layer.cornerRadius = 5;
        _tfAccount.placeholder = @"请输入您的账号";
        _tfAccount.delegate = self;
        [self.view addSubview:_tfAccount];
    }
    return _tfAccount;
}
- (UITextField *)tfPassword
{
    if (!_tfPassword) {
        _tfPassword = [[UITextField alloc] initWithFrame:CGRectMake(50, 211, self.view.width - 100, 30)];
        _tfPassword.backgroundColor = UIColorFromRGB(0xeeeeee);
        _tfPassword.layer.cornerRadius = 5;
        _tfPassword.placeholder = @"请输入您的密码";
        _tfPassword.delegate = self;
        [self.view addSubview:_tfPassword];
    }
    return _tfPassword;
}

- (UIButton *)logInButton
{
    if (!_logInButton) {
        _logInButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 316, self.view.width - 60, 44)];
        [_logInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logInButton setTitle:@"确定" forState:UIControlStateNormal];
        [_logInButton setBackgroundImage:[UIImage imageNamed:@"btn_qd"] forState:UIControlStateNormal];
        [_logInButton addTarget:self action:@selector(LogIn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_logInButton];
    }
    return _logInButton;
}

#pragma mark - 登陆方法
- (void)LogIn
{
    //登陆成功，则保存isLogin的值为true到偏好设置中。失败则为false
    DZMainViewController * mainVc = [[DZMainViewController alloc] init];
    
    DZNavigationController * nav = [[DZNavigationController alloc] initWithRootViewController:mainVc];
    
    self.view.window.rootViewController = nav;
}

#pragma mark - 键盘弹出事件
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.view.width <375) {
        // 设置键盘移动时间
        NSTimeInterval animationDuration = 0.1f;
        // 创建执行动画
        [UIView beginAnimations:@"changeKeyboard" context:nil];
        
        [UIView setAnimationDuration:animationDuration];
        
        self.view.frame = CGRectMake(0, -30, self.view.width, self.view.height);
        // 开始动画
        [UIView commitAnimations];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.view.width <375) {
        NSTimeInterval animationDuration = 0.1f;
        
        [UIView beginAnimations:@"changeKeyboard" context:nil];
        
        [UIView setAnimationDuration:animationDuration];
        
        self.view.frame = CGRectMake(0, 64, self.view.width, self.view.height);
        
        [UIView commitAnimations];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
