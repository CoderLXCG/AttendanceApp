//
//  DZPopMenu.m
//  Arkenstone
//
//  Created by 杜仲 on 2016/11/15.
//  Copyright © 2016年 F. All rights reserved.
//

#import "DZPopMenu.h"

@interface DZPopMenu()
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (weak, nonatomic) IBOutlet UIButton *groupButton;
@property (weak, nonatomic) IBOutlet UILabel *marginLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation DZPopMenu

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _friendButton.tag = DZPopMenuTagFriend;
    _groupButton.tag = DZPopMenuTagGroup;
    _cancelButton.tag = DZPopMenuTagCancel;
    _marginLabel.backgroundColor = kGreyColor;
    
}


- (void)hideInPoint:(CGPoint)point
{
    [self removeFromSuperview];
    
//    // pop菜单(平移+缩放)
//    [UIView animateWithDuration:1 animations:^{
//        
//        self.center = point;
//        
//        // 形变
//        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
//        
//    } completion:^(BOOL finished) {
//        // 移除
//        [self removeFromSuperview];
//    }];
    
}
// 点击关闭按钮
- (IBAction)close:(UIButton *)sender {
    
    // 通知代理,移除菜单 移除蒙版
    if ([_delegate respondsToSelector:@selector(popMenuDidClickClose:withTag:)]) {
        [_delegate popMenuDidClickClose:self withTag:sender.tag];
    }
    
    
}

+ (instancetype)showInPoint:(CGPoint)point
{
    
    DZPopMenu *menu = [[NSBundle mainBundle] loadNibNamed:@"DZPopMenu" owner:nil options:nil][0];
    
    menu.center = point;
    
    // 获取主窗口
    [[UIApplication sharedApplication].keyWindow addSubview:menu];
    
    return menu;
}

@end
