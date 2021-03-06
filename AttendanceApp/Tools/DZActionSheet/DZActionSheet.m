//
//  DZActionSheet.m
//  ActionSheet
//
//  Created by 杜仲 on 16/10/12.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "DZActionSheet.h"

//主题色
#define kkColorMain [UIColor colorWithRed:92.0/256.0 green:201.0/256.0 blue:108.0/256.0 alpha:1]
//全局背景色
#define kkColorBackground [UIColor colorWithRed:236.0/255.0 green:239.0/255.0 blue:240.0/255.0 alpha:1.0]
//全局Cell分割线
#define kkColorCellLine [UIColor colorWithWhite:0.9 alpha:1.0]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define CANCEL_BUTTON_COLOR                     [UIColor blackColor]
#define DESTRUCTIVE_BUTTON_COLOR                [UIColor colorWithRed:255.0/255.0f green:90.0/255.00f blue:95.0/255.00f alpha:1]
#define OTHER_BUTTON_COLOR                      [UIColor whiteColor]

#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:106/255.00f green:106/255.00f blue:106/255.00f alpha:0.8]
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define CORNER_RADIUS                           3 // 5

#define BUTTON_INTERVAL_HEIGHT                  10 //与顶部titleLabel的间距
#define BUTTON_HEIGHT                           36
#define BUTTON_INTERVAL_WIDTH                   20
#define BUTTONTITLE_FONT                        [UIFont systemFontOfSize:16.0]
#define BUTTON_BORDER_WIDTH                     0.0//动画时间
#define BUTTON_BORDER_COLOR                     [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3].CGColor


#define TITLE_INTERVAL_HEIGHT                   40
#define TITLE_HEIGHT                            35
#define TITLE_INTERVAL_WIDTH                    30
#define TITLE_FONT                              [UIFont systemFontOfSize:16.0]
#define TITLE_NUMBER_LINES                      0
#define ANIMATE_DURATION                        0.0f
#define MARGIN_WIDTH                            40

@interface DZActionSheet ()

@property (nonatomic, assign) CGSize labelSize;
@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) NSString *actionTitle;
@property (nonatomic,assign) NSInteger postionIndexNumber;
@property (nonatomic,assign) BOOL isHadTitle;
@property (nonatomic,assign) BOOL isHadDestructionButton;
@property (nonatomic,assign) BOOL isHadOtherButton;
@property (nonatomic,assign) BOOL isHadCancelButton;
@property (nonatomic,assign) CGFloat DZActionSheetHeight;
@property (nonatomic,assign) id<DZActionSheetDelegate>delegate;

@end

@implementation DZActionSheet

#pragma mark - Public method

- (id)initWithTitle:(NSString *)title delegate:(id<DZActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray;
{
    self = [super init];
    if (self) {
    
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
//      [self addGestureRecognizer:tapGesture];
    
        if (delegate) {
            self.delegate = delegate;
        }
    
        [self creatButtonsWithTitle:title cancelButtonTitle:cancelButtonTitle destructionButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitlesArray];

    }
    return self;
}

- (UIViewController *)viewController:(UIView *)view{
    UIResponder *responder = view;
    
    while ((responder = [responder nextResponder]))
        
        if ([responder isKindOfClass: [UIViewController class]])
            
            return (UIViewController *)responder;
    return nil;
    
}

- (void)showInView:(UIView *)view
{
    
    [view.window addSubview:self];
    
}

#pragma mark - CreatButtonAndTitle method

- (void)creatButtonsWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructionButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray
{
    //初始化
    self.isHadTitle = NO;
    self.isHadDestructionButton = NO;
    self.isHadOtherButton = NO;
    self.isHadCancelButton = NO;

    //初始化LXACtionView的高度为0
    self.DZActionSheetHeight = 0;

    //初始化IndexNumber为0;
    self.postionIndexNumber = 0;
    
    //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width,0)];
    
    self.backGroundView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    //给DZActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
    [self.backGroundView addGestureRecognizer:tapGesture];
    
    [self addSubview:self.backGroundView];
    
    if (title) {
        self.isHadTitle = YES;
        UILabel *titleLabel = [self creatTitleLabelWith:title];

        self.DZActionSheetHeight = self.DZActionSheetHeight + 2*TITLE_INTERVAL_HEIGHT + _labelSize.height ;
        [self.backGroundView addSubview:titleLabel];
    }

    if (destructiveButtonTitle) {
        self.isHadDestructionButton = YES;
        
        UIButton *destructiveButton = [self creatDestructiveButtonWith:destructiveButtonTitle];
        destructiveButton.tag = self.postionIndexNumber;
        [destructiveButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.isHadTitle == YES) {
            //当有title时
            [destructiveButton setFrame:CGRectMake(BUTTON_INTERVAL_WIDTH +(self.bounds.size.width - BUTTON_INTERVAL_WIDTH * 2 -10 - MARGIN_WIDTH)/2 +7,self.DZActionSheetHeight, (self.bounds.size.width - BUTTON_INTERVAL_WIDTH * 2 -10 - MARGIN_WIDTH)/2, BUTTON_HEIGHT)];
            
            if (otherButtonTitlesArray && otherButtonTitlesArray.count > 0) {
                self.DZActionSheetHeight = self.DZActionSheetHeight + destructiveButton.frame.size.height+BUTTON_INTERVAL_HEIGHT/2;
            }
            else if (!cancelButtonTitle){
                [destructiveButton setFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, self.DZActionSheetHeight, ([UIScreen mainScreen].bounds.size.width - BUTTON_INTERVAL_WIDTH * 2  - MARGIN_WIDTH), BUTTON_HEIGHT)];

                
                self.DZActionSheetHeight = self.DZActionSheetHeight + destructiveButton.frame.size.height+BUTTON_INTERVAL_HEIGHT;
            }
        }
        else{
            //当无title时
            if (otherButtonTitlesArray && otherButtonTitlesArray.count > 0) {
                self.DZActionSheetHeight = self.DZActionSheetHeight + destructiveButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT+(BUTTON_INTERVAL_HEIGHT/2));
            }
            else if (!cancelButtonTitle){
                [destructiveButton setFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, self.DZActionSheetHeight +5, ([UIScreen mainScreen].bounds.size.width - BUTTON_INTERVAL_WIDTH * 2  - MARGIN_WIDTH), BUTTON_HEIGHT)];

                self.DZActionSheetHeight = self.DZActionSheetHeight + destructiveButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
            }
        }
        [self.backGroundView addSubview:destructiveButton];
        
        self.postionIndexNumber++;
    }
    
    if (otherButtonTitlesArray) {
        if (otherButtonTitlesArray.count > 0) {
            self.isHadOtherButton = YES;
  
            //当无title与destructionButton时
            if (self.isHadTitle == NO && self.isHadDestructionButton == NO) {
                for (int i = 0; i<otherButtonTitlesArray.count; i++) {
                    UIButton *otherButton = [self creatOtherButtonWith:[otherButtonTitlesArray objectAtIndex:i] withPostion:i];
                    
                    otherButton.tag = self.postionIndexNumber;
                    [otherButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
                    
                    if (i != otherButtonTitlesArray.count - 1) {
                        self.DZActionSheetHeight = self.DZActionSheetHeight + otherButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT/2);
                    }
                    else{
                        self.DZActionSheetHeight = self.DZActionSheetHeight + otherButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
                    }
                    
                    [self.backGroundView addSubview:otherButton];
                
                    self.postionIndexNumber++;
                }
            }
            
            //当有title或destructionButton时
            if (self.isHadTitle == YES || self.isHadDestructionButton == YES) {
                for (int i = 0; i<otherButtonTitlesArray.count; i++) {
                    UIButton *otherButton = [self creatOtherButtonWith:[otherButtonTitlesArray objectAtIndex:i] withPostion:i];
            
                    otherButton.tag = self.postionIndexNumber;
                    [otherButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
                    [otherButton setFrame:CGRectMake(otherButton.frame.origin.x, self.DZActionSheetHeight, otherButton.frame.size.width - MARGIN_WIDTH, otherButton.frame.size.height)];
                    
                    if (i != otherButtonTitlesArray.count - 1) {
                        self.DZActionSheetHeight = self.DZActionSheetHeight + otherButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT/2);
                    }
                    else{
                        self.DZActionSheetHeight = self.DZActionSheetHeight + otherButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT);
                    }
                    
                    [self.backGroundView addSubview:otherButton];
                    
                    self.postionIndexNumber++;
                }
            }
        }
    }

    if (cancelButtonTitle) {
        self.isHadCancelButton = YES;
        
        UIButton *cancelButton = [self creatCancelButtonWith:cancelButtonTitle];
        
        cancelButton.tag = self.postionIndexNumber;
        [cancelButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
        
//        当没title destructionButton otherbuttons时
        if (self.isHadTitle == NO && self.isHadDestructionButton == NO && self.isHadOtherButton == NO) {
             self.DZActionSheetHeight = self.DZActionSheetHeight + cancelButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
        }
        
//        当有title或destructionButton或otherbuttons时
        if (self.isHadTitle == YES || self.isHadDestructionButton == YES || self.isHadOtherButton == YES) {
            [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, self.DZActionSheetHeight, (self.bounds.size.width - BUTTON_INTERVAL_WIDTH * 2 -10 - MARGIN_WIDTH)/2, BUTTON_HEIGHT)];
            self.DZActionSheetHeight = self.DZActionSheetHeight + cancelButton.frame.size.height+BUTTON_INTERVAL_HEIGHT;
        }
        
        [self.backGroundView addSubview:cancelButton];
        
        self.postionIndexNumber++;
    }
    //
        [UIView animateWithDuration:ANIMATE_DURATION animations:^{
            [self.backGroundView setFrame:CGRectMake(MARGIN_WIDTH/2, ([UIScreen mainScreen].bounds.size.height-self.DZActionSheetHeight)/2 , [UIScreen mainScreen].bounds.size.width - MARGIN_WIDTH,self.DZActionSheetHeight)];
        } completion:^(BOOL finished) {
        }];

    
}

- (UILabel *)creatTitleLabelWith:(NSString *)title
{
    _labelSize = [title boundingRectWithSize:CGSizeMake(self.bounds.size.width - 2 * TITLE_INTERVAL_WIDTH - MARGIN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TITLE_FONT} context:nil].size;
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_INTERVAL_WIDTH, TITLE_INTERVAL_HEIGHT, self.bounds.size.width - 2 * TITLE_INTERVAL_WIDTH - MARGIN_WIDTH, _labelSize.height)];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = TITLE_FONT;
    titlelabel.text = title;
    titlelabel.textColor = [UIColor darkGrayColor];
    titlelabel.numberOfLines = TITLE_NUMBER_LINES;
    return titlelabel;
}

- (UIButton *)creatDestructiveButtonWith:(NSString *)destructiveButtonTitle
{
    UIButton *destructiveButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT, (self.bounds.size.width - BUTTON_INTERVAL_WIDTH * 2 -10 - MARGIN_WIDTH)/2, BUTTON_HEIGHT)];
    destructiveButton.layer.masksToBounds = YES;
    destructiveButton.layer.cornerRadius = CORNER_RADIUS;
    
    destructiveButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
    destructiveButton.layer.borderColor = BUTTON_BORDER_COLOR;
    
    destructiveButton.backgroundColor = kkColorMain;//DESTRUCTIVE_BUTTON_COLOR;
    [destructiveButton setTitle:destructiveButtonTitle forState:UIControlStateNormal];
    destructiveButton.titleLabel.font = BUTTONTITLE_FONT;
    
    [destructiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [destructiveButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return destructiveButton;
}

- (UIButton *)creatCancelButtonWith:(NSString *)cancelButtonTitle
{
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT, (self.bounds.size.width - BUTTON_INTERVAL_WIDTH * 2 -10 - MARGIN_WIDTH)/2, BUTTON_HEIGHT)];
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.cornerRadius = CORNER_RADIUS;
    
    cancelButton.backgroundColor = [UIColor whiteColor];//CANCEL_BUTTON_COLOR;
    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = BUTTONTITLE_FONT;
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return cancelButton;
}

- (UIButton *)creatOtherButtonWith:(NSString *)otherButtonTitle withPostion:(NSInteger )postionIndex
{
    UIButton *otherButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT + (postionIndex*(BUTTON_HEIGHT+(BUTTON_INTERVAL_HEIGHT/2))), self.bounds.size.width - 2 * BUTTON_INTERVAL_WIDTH, BUTTON_HEIGHT)];
    otherButton.layer.masksToBounds = YES;
    otherButton.layer.cornerRadius = CORNER_RADIUS;
    
    otherButton.layer.borderWidth = BUTTON_BORDER_WIDTH;
    otherButton.layer.borderColor = BUTTON_BORDER_COLOR;
    
    otherButton.backgroundColor = OTHER_BUTTON_COLOR;
    [otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
    otherButton.titleLabel.font = BUTTONTITLE_FONT;
    [otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [otherButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return otherButton;
}

- (void)clickOnButtonWith:(UIButton *)button
{
    if (self.isHadDestructionButton == YES) {
        if (self.delegate) {
            if (button.tag == 0) {
                if ([self.delegate respondsToSelector:@selector(didClickOnDestructiveButton)] == YES){
                    [self.delegate didClickOnDestructiveButton];
                }
                if ([self.delegate respondsToSelector:@selector(didClickOnSureButtonWithActionSheet:)]) {
                    [self.delegate didClickOnSureButtonWithActionSheet:self];
                }
            }
        }
    }
    
    if (self.isHadCancelButton == YES) {
        if (self.delegate) {
            if (button.tag == self.postionIndexNumber-1) {
                if ([self.delegate respondsToSelector:@selector(didClickOnCancelButton)] == YES) {
                    [self.delegate didClickOnCancelButton];
                }
            }
        }
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didClickOnButtonIndex:)] == YES) {
            [self.delegate didClickOnButtonIndex:(NSInteger *)button.tag];
        }
    }
    
    [self tappedCancel];
}

- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)tappedBackGroundView
{
    //
}

@end
