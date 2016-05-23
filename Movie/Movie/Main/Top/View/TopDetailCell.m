//
//  TopDetailCell.m
//  Movie
//
//  Created by ZhugeZhan on 16/4/9.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "TopDetailCell.h"

@implementation TopDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetailModel:(TopDetailModel *)detailModel {
    
    _detailModel = detailModel;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_detailModel.userImage] placeholderImage:[UIImage imageNamed:@"pig"]];
    
    _nickLabel.text = _detailModel.nickname;
    _scoreLabel.text = _detailModel.rating;
    _cmmtLabel.text = _detailModel.content;
}


@end
