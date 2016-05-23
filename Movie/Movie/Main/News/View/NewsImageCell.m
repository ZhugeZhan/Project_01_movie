//
//  NewsImageCell.m
//  Movie
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "NewsImageCell.h"

@implementation NewsImageCell

- (void)awakeFromNib {
    
    _imgView.layer.cornerRadius = 10;
    _imgView.layer.masksToBounds = YES;
}

- (void)setModel:(ImageModel *)model
{
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.image]];
}

@end
