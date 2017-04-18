//
//  NSArray+LOG.m
//  MJRefresh_demo
//
//  Created by 马健 on 2016/12/23.
//  Copyright © 2016年 iWangding. All rights reserved.
//

#import "NSArray+LOG.h"

@implementation NSArray (LOG)

- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level
{
    NSMutableString *string = [NSMutableString string];
     // 开头有个[
     [string appendString:@"(\n"];
    // 遍历所有的元素
     [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [string appendFormat:@"\t%@,\n", obj];
     }];
     // 结尾有个]
     [string appendString:@")"];
     // 查找最后一个逗号
     NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
     if (range.location != NSNotFound)
         [string deleteCharactersInRange:range];
     return string;
}


@end
