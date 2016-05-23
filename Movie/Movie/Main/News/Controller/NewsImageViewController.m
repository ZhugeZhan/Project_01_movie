//
//  NewsImageViewController.m
//  Movie
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "NewsImageViewController.h"
#import "NewsImageCell.h"
#import "PhotoViewController.h"

#define kItemWidth 80
#define kItemHeight 66
#define kItemCount 4

#define kItemSpace (kScreenWidth - kItemWidth * kItemCount) / (kItemCount + 1)

@interface NewsImageViewController ()
{
    NSMutableArray *dataArr;
}

@end

@implementation NewsImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"图片新闻";
    
    //加载数据
    [self _loadData];
    //配置UI
    [self _configUI];
}

- (void)_loadData
{
    dataArr = [NSMutableArray array];
    
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_list" ofType:@"json"]] options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dic in arr) {
        ImageModel *model = [[ImageModel alloc] init];
        
        model.imageId = [dic[@"id"] integerValue];
        model.image = dic[@"image"];
        model.type = [dic[@"type"] integerValue];
        
        [dataArr addObject:model];
    }
}


- (void)_configUI
{
    //适配，一行4个
    
    //item的大小
    self.collectionFlowLayout.itemSize = CGSizeMake(kItemWidth, kItemHeight);
    //行与行的间距
    self.collectionFlowLayout.minimumLineSpacing = kItemSpace;
    //同一行item之间的距离
    self.collectionFlowLayout.minimumInteritemSpacing = kItemSpace;
    //相对于边的偏移量：上 左 下 右
    self.collectionFlowLayout.sectionInset = UIEdgeInsetsMake(kItemSpace, kItemSpace, 0, kItemSpace);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewsImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewsImageCell" forIndexPath:indexPath];
    
    //调用的对象是UICollectionViewCell
    cell.model = dataArr[indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kItemWidth, kItemHeight);
}

//选中cell操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建VC
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    
    //传入选择的indexPath
    photoVC.selectIndexPath = indexPath;
    
    //从dataArr中取出所有的图片地址
    NSMutableArray *array = [NSMutableArray array];
    for (ImageModel *model in dataArr) {
        [array addObject:model.image];
    }
    
    photoVC.imageURLArr = array;
    
    //通过push，弹出视图控制器
    [self.navigationController pushViewController:photoVC animated:YES];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
