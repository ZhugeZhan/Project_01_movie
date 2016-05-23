//
//  LargeCell.h
//  Movie
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCell.h"

/*
 大图，cell的具体配置
 */

@interface LargeCell : UICollectionViewCell
{
    __weak IBOutlet UIImageView *imgView;
}

@property (nonatomic, strong) HomeModel *model;

@end
