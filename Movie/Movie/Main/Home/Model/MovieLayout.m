//
//  MovieLayout.m
//  Movie
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "MovieLayout.h"

@implementation MovieLayout

- (instancetype)init
{
    if (self = [super init]) {
        //滚动的方向 水平
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return self;
}

@end
