//
//  DZCover.m
//  Arkenstone
//
//  Created by 杜仲 on 2016/11/15.
//  Copyright © 2016年 F. All rights reserved.
//

#import "DZCover.h"

@implementation DZCover

+ (void)show
{
    // 设置父控件的透明度会影响子控件
    
    DZCover *cover = [[DZCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    cover.backgroundColor = [UIColor blackColor];
    
    cover.alpha = 0.5;
    
//    cover.userInteractionEnabled = YES;
//    
//    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    
    // 在开发中,只要把一个控件显示在最外边,就把他添加到主窗口上.
    // 获取主窗口
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    
}

+ (void)hide
{
    
    // 移除蒙版
    for (UIView *childView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([childView isKindOfClass:self]) {
            [childView removeFromSuperview];
        }
    }
}

@end
