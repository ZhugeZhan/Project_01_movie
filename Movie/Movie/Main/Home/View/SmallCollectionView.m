//
//  SmallCollectionView.m
//  Movie
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "SmallCollectionView.h"

@implementation SmallCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if(self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.itemWidth = 70;
        
        [self registerNib:[UINib nibWithNibName:@"SmallCell" bundle:nil] forCellWithReuseIdentifier:@"SmallCell"];
    }
    return self;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SmallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SmallCell" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

@end
