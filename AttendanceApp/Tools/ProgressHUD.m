//
//  ProgressShow.m
//  Arkenstone
//
//  Created by 马健 on 2016/12/15.
//  Copyright © 2016年 F. All rights reserved.
//

#import "ProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIImage+GIF.h"
@interface ProgressHUD ()
@end

@implementation ProgressHUD

+ (void)showHUDWithTitle:(NSString *)title view:(UIView *)view
{
    MBProgressHUD *customHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    customHUD.label.text = title;
    customHUD.label.font = Main_Font;
    customHUD.mode = MBProgressHUDModeCustomView;
    UIImage *image = [UIImage sd_animatedGIFNamed:@"tt-2"];
    UIImageView *animationView = [[UIImageView alloc] initWithImage:image];
    customHUD.customView = animationView;
}

+ (void)showSuccesedWithTitle:(NSString *)title view:(UIView *)view
{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.label.text = title;
    hub.mode = MBProgressHUDModeCustomView;
    hub.animationType = MBProgressHUDAnimationZoom;
    hub.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_gou"]];
    [hub hideAnimated:YES afterDelay:1.f];
    
}
+ (void)showErrorWithTitle:(NSString *)title view:(UIView *)view
{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.label.text = title;
    hub.mode = MBProgressHUDModeCustomView;
    hub.animationType = MBProgressHUDAnimationZoom;
    hub.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_cha"]];
    [hub hideAnimated:YES afterDelay:1.f];
}

//自定义视图
+ (void)showHUDCustomViewWithImageName:(NSString *)imageName Title:(NSString *)title hideDelay:(CGFloat)delayTimeHide showInView:(UIView *)view{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.label.text = title;
    hub.mode = MBProgressHUDModeCustomView;
    hub.animationType = MBProgressHUDAnimationZoomIn;
    hub.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [hub hideAnimated:YES afterDelay:delayTimeHide];
}

//关闭
+ (void)hideHUDWithView:(UIView *)view;
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud.mode == MBProgressHUDModeCustomView) {
    }
    [MBProgressHUD hideHUDForView:view animated:YES];
}

//旋转动画
+ (void)rotateImageViewWith:(UIImageView *)imageView
{
    //一秒钟转多少圈
    CGFloat circleByOneSecond = 1.5f;
    __weak typeof(self) wSelf = self;
    [UIView animateWithDuration:1.f/circleByOneSecond delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI_2);
    } completion:^(BOOL finished) {
        if (imageView != nil) {
            [wSelf rotateImageViewWith:imageView];
        }
    }];
}

@end
