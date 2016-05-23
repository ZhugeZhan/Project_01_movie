//
//  HomeViewController.m
//  Movie
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "PostView.h"

@interface HomeViewController ()
{
    __weak IBOutlet PostView *_posterView;
    __weak IBOutlet UITableView *_listView;
    
    NSMutableArray *_modelArr;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"电影";
    
    //从json文件中加载数据
    [self _parseJsonData];
    
    _posterView.hidden = YES;
    _listView.backgroundColor = self.view.backgroundColor;
    _listView.separatorColor = kTableViewSeColor;
    
    //视图列表的切换
    [self _createCustomView];
    
}


//从json文件中读取数据
- (void)_parseJsonData {
    
    _modelArr = [NSMutableArray array];
    
    //解压json数据
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"us_box" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    /*
     NSJSONReadingMutableContainers = (1UL << 0), 可变容器
     NSJSONReadingMutableLeaves = (1UL << 1), 可变的字符串
     NSJSONReadingAllowFragments = (1UL << 2) 其他类型，不是数组和字典
     */
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *subjects = result[@"subjects"];
    
    for (NSDictionary *dic in subjects) {
        NSDictionary *subject = dic[@"subject"];
        
        //配置model
        HomeModel *model = [[HomeModel alloc] initWithDic:subject];
        
//        model.rating = subject[@"rating"];
//        model.title = subject[@"title"];
//        model.original_title = subject[@"original_title"];
//        model.images = subject[@"images"];
//        model.year = subject[@"year"];
        
        [_modelArr addObject:model];
    }
    
    //posterView 获取到数据
    _posterView.dataArray = _modelArr;
}




//添加按钮，视图列表的切换
- (void)_createCustomView
{
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    rightButtonView.backgroundColor = [UIColor clearColor];
    
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [postButton setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateNormal];
    [postButton setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    postButton.frame = rightButtonView.frame;
    [postButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:postButton];
    
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [listButton setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    [listButton setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    listButton.frame = rightButtonView.frame;
    [listButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:listButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    
}

- (void)buttonAction:(UIButton *)button
{
    //为什么要拿customView 通过它实现 上面两个button的切换
    UIView *customView = self.navigationItem.rightBarButtonItem.customView;
    //将当前的button放到底层去
    [customView sendSubviewToBack:button];

    //设置转场动画类型，左转还是右转
    UIViewAnimationTransition transition = _posterView.hidden ? UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight;
    
    _listView.hidden = _posterView.hidden;
    _posterView.hidden = !_listView.hidden;
    
    //实际执行的动画
    [UIView animateWithDuration:0.25 animations:^{
        //执行转场动画
        [UIView setAnimationTransition:transition forView:customView cache:YES];
    }];
    //分开写的原因在于，写在同一个里面会使得上一个的切换效果没有
    [UIView animateWithDuration:0.25 animations:^{
        [UIView setAnimationTransition:transition forView:self.view cache:YES];
    }];
}




//表视图的代理方法
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArr.count;
}
//设置单元格数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifierHomeCell"];
    
    if (cell == nil) {
        //从xib文件中读取cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil] firstObject];
        
    }
    
    //cell的值
    cell.model = _modelArr[indexPath.row];
    
    return cell;
}
//设置单元格行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenWidth / 3;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
