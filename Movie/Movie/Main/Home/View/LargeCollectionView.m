//
//  LargeCollectionView.m
//  Movie
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "LargeCollectionView.h"

@implementation LargeCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.itemWidth = kScreenWidth - 100;
        
        //注册cell
        [self registerNib:[UINib nibWithNibName:@"LargeCell" bundle:nil] forCellWithReuseIdentifier:@"LargeCell"];
    }
    return self;
}

//具体实现cell，给cell赋值
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LargeCell" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

//设置item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.itemWidth, self.height - 70);
}

@end
