//
//  GFCalendarCell.m
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import "GFCalendarCell.h"

@implementation GFCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.todayCircle];
        [self addSubview:self.todayLabel];
        [self addSubview:self.workImageView];
        [self addSubview:self.offWorkImageView];
        
    }
    
    return self;
}

- (UIView *)todayCircle {
    if (_todayCircle == nil) {
        _todayCircle = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.8 * self.bounds.size.height, 0.8 * self.bounds.size.height)];
        _todayCircle.center = CGPointMake(0.5 * self.bounds.size.width, 0.5 * self.bounds.size.height);
        _todayCircle.layer.cornerRadius = 0.5 * _todayCircle.frame.size.width;
    }
    return _todayCircle;
}

- (UILabel *)todayLabel {
    if (_todayLabel == nil) {
        _todayLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _todayLabel.textAlignment = NSTextAlignmentCenter;
        _todayLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _todayLabel.backgroundColor = [UIColor clearColor];
    }
    return _todayLabel;
}

- (UIImageView *)workImageView
{
    if (!_workImageView) {
        _workImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.15*self.height, 0.3 *self.width, 0.3*self.height)];
        _workImageView.image = [UIImage imageNamed:@"shang"];
        _workImageView.hidden = YES;
    }
    return _workImageView;
}

- (UIImageView *)offWorkImageView
{
    if (!_offWorkImageView) {
        _offWorkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.55 * self.height, 0.3 *self.width, 0.3*self.height)];
        _offWorkImageView.image = [UIImage imageNamed:@"xia"];
        _offWorkImageView.hidden = YES;
    }
    return _offWorkImageView;
}

@end
