//
//  HomeCell.m
//  Movie
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 无限互联. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(HomeModel *)model
{
    _model = model;
    
    self.titleLabel.text = _model.title;
    self.titleLabel.textColor = [UIColor colorWithRed:122.0/255 green:59.0/255 blue:19.0/255 alpha:1];
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f",[_model.rating[@"average"] floatValue]];
    self.yearLabel.text = [NSString stringWithFormat:@"年份：%@",_model.year];
    
    //先用本地图片赋值，然后通过图片链接下载成数据（data），再对data进行转码成图片，显示到界面上
    NSString *imageUrl = _model.images[@"medium"];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"pig"]];
    
    [_starView changeStarViewWidthWithRating:[self.ratingLabel.text floatValue]];
    
}

@end
