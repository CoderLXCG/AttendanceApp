//
//  ProgressShow.h
//  Arkenstone
//
//  Created by 马健 on 2016/12/15.
//  Copyright © 2016年 F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MJProgressHUDMode) {
    MJHUDModeIndeterminate,//系统小菊花
    MJHUDModeDeterminate,//使用一个圆环
    MJHUDModeDeterminateHorizontalBar,//横条进度条
    MJHUDModeAnnularDeterminate,//使用一个圆形饼图作为进度视图
    MJHUDModeText//只显示文本
};

@interface ProgressHUD : NSObject
//一般调用这个方法,圆环
/**
 一般加载样式
 
 @param title 提示文字
 @param view 加载位置
 */
+ (void)showHUDWithTitle:(NSString *)title view:(UIView *)view;
/**
 自定义成功失败HUD
 */
//成功
+ (void)showSuccesedWithTitle:(NSString *)title view:(UIView *)view;
//失败
+ (void)showErrorWithTitle:(NSString *)title view:(UIView *)view;
/**
 自定义视图
 @param imageName 图片名字String
 @param title 文字
 @param delayTimeHide 延迟多久消失
 @param view 加载位置
 */
+ (void)showHUDCustomViewWithImageName:(NSString *)imageName
                                 Title:(NSString *)title
                             hideDelay:(CGFloat)delayTimeHide
                            showInView:(UIView *)view;
//关闭HUD

/**
 关闭当前页面的HUD

 @param view 加载位置
 */
+ (void)hideHUDWithView:(UIView *)view;

@end
