//
//  TabBarButton.m
//  Movie
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "TabBarButton.h"

#define kItemSize 20

//TabBar的高度为49

@implementation TabBarButton

- (instancetype)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName withTitle:(NSString *)title {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //self.frame = frame;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - kItemSize) / 2, 5, kItemSize, kItemSize)];
        _imageView.image = [UIImage imageNamed:imageName];
        _imageView.contentMode = UIViewContentModeScaleAspectFit; //_imageView上的内容按比例填充
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame) + 5, frame.size.width, 15)];
        //CGRectGetMaxY 获取控件底部的y值
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLabel];
    }
    return self;
}

// 选中状态的图片设置
- (void)imageForSelected:(NSString *)imgName {
    
    self.selected = YES;
    _imageView.image = [UIImage imageNamed:imgName];
    
}


@end
