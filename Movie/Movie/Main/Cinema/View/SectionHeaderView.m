//
//  SectionHeaderView.m
//  Movie
//
//  Created by ZhugeZhan on 16/4/21.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UIControl *ctrl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSectionHeaderHeight)];
    ctrl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hotMovieBottomImage"]];
    _ctrlView = ctrl;
    [self addSubview:_ctrlView];
    
    //显示文字
    UILabel *titelLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (kSectionHeaderHeight - 21) / 2, kScreenWidth, 21)];
    titelLabel.font = [UIFont boldSystemFontOfSize:20];
    titelLabel.textColor = [UIColor colorWithWhite:0.92 alpha:1];
    titelLabel.backgroundColor = [UIColor clearColor];
    _titleLabel = titelLabel;
    [self addSubview:_titleLabel];
}

@end
