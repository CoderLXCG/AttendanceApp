//
//  UILabel+DZAutoSize.m
//  Arkenstone
//
//  Created by 杜仲 on 2016/11/7.
//  Copyright © 2016年 F. All rights reserved.
//

#import "UILabel+DZAutoSize.h"

@implementation UILabel (DZAutoSize)

- (CGSize)sizeWithText:(NSString *)text andMaxSize:(CGSize)maxSize andFont:(UIFont *)font
{
    NSDictionary *attr = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

- (CGSize)FXAutoSize
{
    return [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
}

@end
