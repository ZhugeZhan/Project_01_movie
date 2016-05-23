//
//  TopViewController.m
//  Movie
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "TopViewController.h"
#import "TopCollectionViewCell.h"
#import "TopDetailViewController.h"

#define kSpaceSize (kScreenWidth-kItemWidth*kItemCount)/(kItemCount+1)

@interface TopViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *topFlowLayout;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"TOP250";
    
    //加载数据
    [self _loadData];
    //布局界面
    [self _UIconfig];
    
}


- (void)_loadData {
    
    _dataArr = [NSMutableArray array];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"top250" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    id resule = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *arr = [resule objectForKey:@"subjects"];
    
    for (NSDictionary *dic in arr) {
        
        TopModel *model = [[TopModel alloc] init];
        model.rating = dic[@"rating"];
        model.images = dic[@"images"];
        model.title = dic[@"title"];
        model.year = dic[@"year"];
        
        [_dataArr addObject:model];
    }
}

- (void)_UIconfig {
    self.topFlowLayout.itemSize = CGSizeMake(kItemWidth, kItemHeight);
    self.topFlowLayout.minimumLineSpacing = kSpaceSize;
    self.topFlowLayout.minimumInteritemSpacing = kSpaceSize;
    self.topFlowLayout.sectionInset = UIEdgeInsetsMake(kSpaceSize, kSpaceSize, kSpaceSize, kSpaceSize);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCollectionViewCellID" forIndexPath:indexPath];
    cell.model = _dataArr[indexPath.row];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TopDetailViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TopDetailViewControllerID"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
