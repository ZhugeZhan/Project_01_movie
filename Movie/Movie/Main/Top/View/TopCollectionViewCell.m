//
//  TopCollectionViewCell.m
//  Movie
//
//  Created by ZhugeZhan on 16/4/8.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "TopCollectionViewCell.h"

#define kStarHeight 13.0

@implementation TopCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    titleLabel.alpha = 0.7;

    //用代码创建星星视图，调用initWithFrame
    starView = [[StarViewCode alloc] initWithFrame:CGRectMake(0, imgView.height, kStarHeight * 5, kStarHeight)];
    
    [self.contentView addSubview:starView];
}

- (void)setModel:(TopModel *)model {
    
    _model = model;
    
    //加载电影图片
    NSString *imgStr = [_model.images objectForKey:@"medium"];
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"pig"]];
    
    //显示电影标题
    titleLabel.text = _model.title;
    
    //显示评分
    NSNumber *ratingNum = [_model.rating objectForKey:@"average"];
    scoreLabel.text = [NSString stringWithFormat:@"%.1f", [ratingNum floatValue]];
    
    //显示星星
    [starView changeStarViewWidthWithRating:[ratingNum floatValue]];
}

@end
