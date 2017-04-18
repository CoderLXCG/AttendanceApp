//
//  DZPopMenu.h
//  Arkenstone
//
//  Created by 杜仲 on 2016/11/15.
//  Copyright © 2016年 F. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum DZPopMenuTag
{
    DZPopMenuTagFriend = 1,
    DZPopMenuTagGroup = 2,
    DZPopMenuTagCancel = 3,
}DZPopMenuTag;

@class DZPopMenu;

@protocol DZPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidClickClose:(DZPopMenu *)popMenu withTag:(NSInteger)DZPopMenuTag;

@end

@interface DZPopMenu : UIView

@property (nonatomic, weak) id<DZPopMenuDelegate> delegate;

+ (instancetype)showInPoint:(CGPoint)point;
- (void)hideInPoint:(CGPoint)point;

@end
