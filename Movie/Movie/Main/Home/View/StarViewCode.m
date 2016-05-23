//
//  StarViewCode.m
//  Movie
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "StarViewCode.h"

@implementation StarViewCode

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

//从nib文件当中去加载时候会调用initWithCoder
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self createSubviews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//用代码创建（StarViewCode *starView）的时候需要调用这里面的内容初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubviews];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

//nib(xib&storyboard) NEXTSTEP interface bulider -> xcode interface builder

/*
//从nib文件当中去加载时候会调用awakeFromNib
 
- (void)awakeFromNib
{
    [super awakeFromNib];
 
    [self createSubviews];
    self.backgroundColor = [UIColor clearColor];
}
*/


- (void)createSubviews
{
    grayView = [[UIView alloc] init];
    yellowView = [[UIView alloc] init];
    [self addSubview:grayView];
    [self addSubview:yellowView];
    
    //按比例缩放 对于缩放值添加0.5的原因在于，宽高之间存在误差 35 * 34 一个像素的误差，所以如果不添加，星星会显示不完全
    float scale = self.height / (17 + 0.5);
    
    grayView.transform = CGAffineTransformMakeScale(scale, scale);
    yellowView.transform = CGAffineTransformMakeScale(scale, scale);

    //限定平铺范围，需要五颗星所以乘以5
    grayView.frame = CGRectMake(0, 0, 5 * self.height, self.height);

    //colorWithPatternImage:平铺图片
    yellowView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow"]];
    grayView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray"]];
}

// 通过评分计算黄色星的覆盖宽度
- (void)changeStarViewWidthWithRating:(float)rating {
    
    yellowView.frame = CGRectMake(0, 0, 5 * self.height * rating / 10, self.height);
}

@end
