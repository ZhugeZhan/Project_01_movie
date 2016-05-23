//
//  NewsViewController.m
//  Movie
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCell.h"

#define kHeadImageViewHeight 200

@interface NewsViewController () 
{
    
    __weak IBOutlet UITableView *_tableView;
    
    NSMutableArray *_dataArr;
    UIImageView *headerImageView;
    UILabel *label;
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"新闻";
    
    [self _loadData];
    
    [self _configUI];
    
    
}


- (void)_loadData
{
    _dataArr = [NSMutableArray array];
    
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"news_list.json" ofType:nil] ]options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dic in arr) {
        NewsModel *model = [[NewsModel alloc] init];
        
        model.title = dic[@"title"];
        model.summary = dic[@"summary"];
        model.image = dic[@"image"];
        model.newsid = [dic[@"newsid"] integerValue];
        model.newsType = (NewsType)[dic[@"type"] integerValue];
        
        [_dataArr addObject:model];
    }
}


- (void)_configUI
{
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = kTableViewSeColor;
    _tableView.rowHeight = 100;
    
    //头视图底下的图片
    NewsModel *model = _dataArr[0];
    headerImageView = [[UIImageView alloc] init];
    headerImageView.frame = CGRectMake(0, 64, kScreenWidth, kHeadImageViewHeight);
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    [self.view insertSubview:headerImageView belowSubview:_tableView];
    
    // 头视图上的文字
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeadImageViewHeight - 40, kScreenWidth, 40)];
    label.text = model.title;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    
    //头视图设置为透明
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kHeadImageViewHeight)];
    headView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = headView;
    
    [headView addSubview:label];
    
    //移除第一个单元格
    [_dataArr removeObjectAtIndex:0];
    
    //注册单元格
    [_tableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    
    cell.model = _dataArr[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //y坐标的偏移量
    CGFloat ofy = scrollView.contentOffset.y;
    CGFloat top = scrollView.contentInset.top;
    CGFloat y = ofy + top;

    if (y < 0) {   //向下滑动，图片放大
        
        CGFloat width =  kScreenWidth * (kHeadImageViewHeight - y) / kHeadImageViewHeight;     //屏幕宽度*放大倍率
        CGFloat height = kHeadImageViewHeight - y;
        
        headerImageView.frame = CGRectMake((kScreenWidth - width) / 2, 64, width, height);
        
    } else {      // 向上滑动，图片推到屏幕上面
    
        headerImageView.frame = CGRectMake(0, -y + 64, kScreenWidth, kHeadImageViewHeight);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //拿到对应的cell
    NewsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // switch case 语句当中 会造成系统当中的数据应用失败
    NSString *viewCtrlID = nil;
    
    switch (cell.model.newsType) {
        case WordType:
            //弹到文字新闻界面
            viewCtrlID = @"NewsWordViewController";
            break;
        case ImageType:
            //弹到图片新闻界面
            viewCtrlID = @"NewsImageViewController";
            break;
        case VideoType:
            //弹到视频新闻界面
            viewCtrlID = @"NewsVideoViewController";
            break;
        default:
            return ;
            break;
    }
    
    // 从storyboard上通过id 获取相应的viewController
    UIViewController *viewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:viewCtrlID];
    
    //隐藏底部标签栏，当push的时候
    viewCtrl.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
