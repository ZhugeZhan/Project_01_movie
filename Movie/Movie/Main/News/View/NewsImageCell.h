//
//  NewsImageCell.h
//  Movie
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

@interface NewsImageCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, strong) ImageModel *model;

@end
