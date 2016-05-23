//
//  PostView.h
//  Movie
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LargeCollectionView.h"
#import "SmallCollectionView.h"

#define kHeaderHeight 131
#define kMovieSmallViewHeight 100
#define kFooterHeight 35

@interface PostView : UIView
{
    UIImageView *headView;
    UILabel *titleLabel;
    
    UIControl *maskView; //遮盖面板
    
    MovieCollectionView *largeView;
    MovieCollectionView *smallView;
}

@property (nonatomic, strong) NSArray *dataArray;

@end
