//
//  MovieCollectionView.h
//  Movie
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) NSInteger currentIndex; //标记item的序号

@property (nonatomic, assign) CGFloat itemWidth;

@end
