//
//  AppDelegate.m
//  AttendanceApp
//
//  Created by 杜仲 on 2017/4/18.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "AppDelegate.h"
#import "DZLoginViewController.h"
#import "DZMainViewController.h"
#import "DZNavigationController.h"

@interface AppDelegate ()

@property (nonatomic, strong) DZLoginViewController * LoginViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //如果未登陆，则跳转到登陆界面。
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];//获取偏好设置
    if (![[user objectForKey:@"isLogIn"] boolValue]) {
        self.window.rootViewController = [[DZLoginViewController alloc] init];//登陆界面
    }else {
        DZNavigationController * nav = [[DZNavigationController alloc] initWithRootViewController:[[DZMainViewController alloc] init]];
        self.window.rootViewController = nav;//主显示界面
        
    }
    [self.window makeKeyAndVisible];
    return YES;
}

@end
