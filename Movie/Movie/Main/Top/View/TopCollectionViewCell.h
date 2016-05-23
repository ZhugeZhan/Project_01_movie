//
//  TopCollectionViewCell.h
//  Movie
//
//  Created by ZhugeZhan on 16/4/8.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopModel.h"
#import "StarViewCode.h"

#define kItemCount 3 //每行个数
#define kItemWidth 100 //item的宽度
#define kItemHeight 166 //item的高度

@interface TopCollectionViewCell : UICollectionViewCell
{
    __weak IBOutlet UIImageView *imgView;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *scoreLabel;
    
    StarViewCode *starView;
}

@property(nonatomic, strong)TopModel *model;

@end
