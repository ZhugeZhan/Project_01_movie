//
//  CinemaViewController.m
//  Movie
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "CinemaViewController.h"
#import "CinemaCell.h"
#import "SectionHeaderView.h"

@interface CinemaViewController ()
{
    BOOL status[30];
}

@property (weak, nonatomic) IBOutlet UITableView *tbView;

@end

@implementation CinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"影院";
    //导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    [self _configUI];
    [self _loadData];
    
}

- (void)_configUI {
    self.tbView.separatorColor = kTableViewSeColor;
    [self.tbView registerNib:[UINib nibWithNibName:@"CinemaCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"kCinemaCellID"];
}

- (void)_loadData {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"district_list" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    _districtArr = result[@"districtList"];
    
    
    _cinemaDic = [NSMutableDictionary dictionary];
    
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"cinema_list" ofType:@"json"];
    NSData *jsonData2 = [[NSData alloc] initWithContentsOfFile:filePath2];
    id result2 = [NSJSONSerialization JSONObjectWithData:jsonData2 options:NSJSONReadingMutableContainers error:nil];
    NSArray *listArr = result2[@"cinemaList"];
    
    for (NSDictionary *dic in listArr) {
        CinemaModel *model = [[CinemaModel alloc] init];
        //cel中要显示的数据
        model.name = dic[@"name"];
        model.grade = dic[@"grade"];
        model.address = dic[@"address"];
        model.lowPrice = dic[@"lowPrice"];
        model.isSeatSupport = dic[@"isSeatSupport"];
        model.isCouponSupport = dic[@"isCouponSupport"];
        //用来分组需要用到的数据
        model.districtId = dic[@"districtId"];
        
        //model分类，把所在地区ID相同districtId的model放一起
        NSString *districtId = model.districtId;
        
        //去自定义的_cinemaDic中查找districtId是否已经被创建
        NSMutableArray *cinemaArr = [_cinemaDic objectForKey:districtId];
        if (cinemaArr == nil) {
            //如果没有就创建一个空的数组
            cinemaArr = [NSMutableArray array];
            //把空的数组和对应的districtId放到字典里面
            [_cinemaDic setObject:cinemaArr forKey:districtId];
        }
        //把model添加到数组里面
        [cinemaArr addObject:model];
    }
}

//分的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _districtArr.count;
}
//每组中的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!status[section]) {
        return 0;
    }
    
    NSDictionary *dic = _districtArr[section];
    NSString *addressID = dic[@"id"];
    NSArray *arr = _cinemaDic[addressID];
    
    return arr.count;
}

//headerView的配置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"kCinemaHeaderFooterViewID"];
    
    if (headerView == nil) {
        headerView = [[SectionHeaderView alloc] initWithReuseIdentifier:@"kCinemaHeaderFooterViewID"];
        
        //添加点击事件
        [headerView.ctrlView addTarget:self action:@selector(clickSectionHeader:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    headerView.ctrlView.tag = 1000 + section;
    NSDictionary *dic = _districtArr[section];
    headerView.titleLabel.text = dic[@"name"];
    
    return headerView;
}
//组头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

//headerView的点击事件
- (void)clickSectionHeader:(UIControl *)headerCtrlView {
    NSInteger section = headerCtrlView.tag - 1000;
    status[section] = !status[section];
    
    [self.tbView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}

//cell的配置
//按照组号session从地区数组中获取地区字典，从字典中确定地区号，按照地区号从影院字典中获取到影院数组，按照行数row获取到影院信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kCinemaCellID" forIndexPath:indexPath];
    
    NSDictionary *dic = _districtArr[indexPath.section];
    NSString *addressId = dic[@"id"];
    NSArray *arr = _cinemaDic[addressId];
    cell.model = arr[indexPath.row];
    
    return cell;
}
//设定单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
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
