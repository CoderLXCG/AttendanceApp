//
//  UIImage+DZIamge.h
//  根据颜色生成图片
//
//  Created by 杜仲 on 15/8/6.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DZIamge)

+ (UIImage *)imageWithColor:(UIColor *)color;

// 给定一个最原始的图片名称生成一个原始的图片
+ (instancetype)imageWithOriginalImageName:(NSString *)imageName;

- (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

@end
