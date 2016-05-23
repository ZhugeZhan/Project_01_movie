//
//  CinemaCell.m
//  Movie
//
//  Created by ZhugeZhan on 16/4/21.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "CinemaCell.h"

@implementation CinemaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CinemaModel *)model {
    _model = model;
    
    _cinemaNameLabel.text = _model.name;
    _ratingLabel.text = _model.grade;
    _addressLabel.text = _model.address;
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.lowPrice];
    _distanceLabel.text = @"10Km";
    
    if ([_model.isSeatSupport integerValue] == 0) {
        _seatImgView.hidden = YES;
    }
    
    if ([_model.isCouponSupport integerValue] == 0) {
        _couponImgView.hidden = YES;
    }
}

@end
