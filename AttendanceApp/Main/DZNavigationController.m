//
//  DZNavigationController.m
//  Arkenstone
//
//  Created by 杜仲 on 2016/11/16.
//  Copyright © 2016年 F. All rights reserved.
//

#import "DZNavigationController.h"
#import "UIImage+DZIamge.h"

@interface DZNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation DZNavigationController


// 什么调用:第一个次使用这个类或者它的子类的时候
// 不一定只会调用一次
+ (void)initialize
{
//    if (self == [DZNavigationController class]) {
//        
//        // 只影响当前类下面的导航条
//        // 获取当前类下面的导航条
//        UINavigationBar *navBar = [UINavigationBar appearance];
//        // 设置导航条背景图片
//        [navBar setBackgroundImage:[UIImage imageWithColor:kBackgroundColor] forBarMetrics:UIBarMetricsDefault];
//        // 设置导航条文字标题
//        NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
//        // 颜色
//        textAttr[NSForegroundColorAttributeName] = kBlackTitleColor;
//        textAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17];
//        
//        // titleTextAttributes:给标题文字设置属性,(颜色,字体,阴影....)
//        navBar.titleTextAttributes = textAttr;
    
//        [navBar setShadowImage:[self imageWithColor:kGreyColor size:CGSizeMake(kScreenWidth, 1)]];
//    }
}
// 类加载的时候调用
// 这个才是只会调用一次
+ (void)load
{
    // 只想设置一次导航条的背景图片和导航条的标题
    UINavigationBar * navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
//     设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageWithColor:kBackgroundColor] forBarMetrics:UIBarMetricsDefault];
    // 设置导航条文字标题
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    // 颜色
    textAttr[NSForegroundColorAttributeName] = kBlackTitleColor;
    textAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17];
    
    // titleTextAttributes:给标题文字设置属性,(颜色,字体,阴影....)
    navBar.titleTextAttributes = textAttr;
    
    [navBar setShadowImage:[self imageWithColor:kGreyColor size:CGSizeMake(kScreenWidth, 1)]];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer action:@selector(handleNavigationTransition:)];
//    
//    [self.view addGestureRecognizer:pan];
//    
//    pan.delegate = self;
    // 1.恢复滑动返回功能:清空滑动手势代理
//    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.interactivePopGestureRecognizer.delegate = self;
    // 2.想回到导航控制器的根控制器的时候,恢复滑动手势代理,目的:解决假死状态
    
    // 监听导航控制器什么时候回到根控制器
    
    // 设置导航控制器的代理,监听导航控制器什么时候回到根控制器
    self.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark -UINavigationControllerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

// 导航控制器显示一个控制器完成的时候就会调用
- (void)navigationController:(nonnull UINavigationController *)navigationController didShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.childViewControllers[0]) {
        // 回到根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{ // 不是根控制器
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }
}

// 假死状态:程序还在运行,只不过界面不能交互

#pragma mark - 给push方法扩充功能
// 想在push的时候,设置下一个栈顶控制器的导航条的左边按钮
- (void)pushViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated
{
    // viewController:下一个栈顶控制器
    [super pushViewController:viewController animated:animated];
    
    // 不是导航控制器的根控制器才需要设置返回按钮
    if (self.childViewControllers.count > 1) { // 不是根控制器
        // 在iOS7之后,导航控制器自动添加了滑动返回功能,手指往右边滑动,就能回到上一个控制器
        // 注意:如果覆盖系统的返回按钮,滑动返回功能就失效.
        
        // 恢复滑动返回功能
        
        // 设置导航条的左边按钮
        // 设置左边按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriginalImageName:@"icon_dakai"] style:0 target:self action:@selector(back)];
    }
}


// 点击返回按钮的时候调用
- (void)back
{
    // 回到上一个控制器
    [self popViewControllerAnimated:YES];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}


@end

