//
//  TopDetailCell.h
//  Movie
//
//  Created by ZhugeZhan on 16/4/9.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopDetailModel.h"

@interface TopDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *cmmtLabel;

@property (nonatomic, strong) TopDetailModel *detailModel;

@end
