//
//  CinemaCell.h
//  Movie
//
//  Created by ZhugeZhan on 16/4/21.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaModel.h"

@interface CinemaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cinemaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *seatImgView;
@property (weak, nonatomic) IBOutlet UIImageView *couponImgView;

@property (nonatomic, strong) CinemaModel *model;

@end
