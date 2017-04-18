//
//  UILabel+DZAutoSize.h
//  Arkenstone
//
//  Created by 杜仲 on 2016/11/7.
//  Copyright © 2016年 F. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DZAutoSize)

- (CGSize)sizeWithText:(NSString *)text andMaxSize:(CGSize)maxSize andFont:(UIFont *)font;

- (CGSize)FXAutoSize;

@end
