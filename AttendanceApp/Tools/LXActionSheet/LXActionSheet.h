//
//  LXActionSheet.h
//  ActionSheet
//
//  Created by 杜仲 on 16/10/12.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXActionSheet;
@protocol LXActionSheetDelegate <NSObject>
@optional
- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex;
- (void)didClickOnDestructiveButton;
- (void)didClickOnCancelButton;

//点击确定是能确定是哪个actionSheet
- (void)didClickOnSureButtonWithActionSheet:(LXActionSheet *)actionSheet;
@end

@interface LXActionSheet : UIView

- (id)initWithTitle:(NSString *)title delegate:(id<LXActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray;

- (void)showInView:(UIView *)view;

@end
