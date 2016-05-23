//
//  TopDetailViewController.m
//  Movie
//
//  Created by ZhugeZhan on 16/4/9.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "TopDetailViewController.h"
#import "TopDetailCell.h"

#define kTableViewRowHeight 80

@interface TopDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (nonatomic, strong) NSMutableArray *detailArr; //评论数据
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation TopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _UIconfig];
    [self _loadData];
}

- (void)_UIconfig {
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"TopDetailHeaderView" owner:self options:nil] firstObject];
    self.detailTableView.tableHeaderView = _headerView;
    
    self.detailTableView.separatorColor = kTableViewSeColor;
    
    [self.detailTableView registerNib:[UINib nibWithNibName:@"TopDetailCell" bundle:nil] forCellReuseIdentifier:@"TopDetailCellID"];
}

- (void)_loadData {
    //解析Header数据
    NSString *headerFilePath = [[NSBundle mainBundle] pathForResource:@"movie_detail" ofType:@"json"];
    NSData *headerJsonData = [NSData dataWithContentsOfFile:headerFilePath];
    id headerResult = [NSJSONSerialization JSONObjectWithData:headerJsonData options:NSJSONReadingMutableContainers error:nil];
    TopDetailHeaderModel *headerModel = [[TopDetailHeaderModel alloc] init];
    headerModel.image = headerResult[@"image"];
    headerModel.titleCn = headerResult[@"titleCn"];
    headerModel.titleEn = headerResult[@"titleEn"];
    headerModel.content = headerResult[@"content"];
    headerModel.videos = headerResult[@"videos"];
    _headerView.model = headerModel;

    
    //解析评论数据
    _detailArr = [NSMutableArray array];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"movie_comment" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];

    NSArray *listArr = result[@"list"];
    
    for (NSDictionary *dic in listArr) {
    
        TopDetailModel *model = [[TopDetailModel alloc] init];
        model.userImage = dic[@"userImage"];
        model.nickname = dic[@"nickname"];
        model.rating = dic[@"rating"];
        model.content = dic[@"content"];
        
        [_detailArr addObject:model];
    }
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopDetailCellID" forIndexPath:indexPath];
    cell.detailModel = self.detailArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([self.selectIndexPath isEqual:indexPath]) {
        
        //求label文字的高度
        TopDetailModel *model = self.detailArr[indexPath.row];
        
        NSDictionary *arrtDic = @{NSFontAttributeName : [UIFont systemFontOfSize:16]};
        
        /*
         NSStringDrawingUsesLineFragmentOrigin 可以换行
         NSStringDrawingUsesFontLeading  计算行高时使用行间距 字体大小+行间距=行高
         NSStringDrawingUsesDeviceMetrics    使用设备的字体 默认印刷字体
         NSStringDrawingTruncatesLastVisibleLine   最后一行如果超出范围，自动变为省略号 （如果不换行，没有效果）
         */
        
        CGRect fram = [model.content boundingRectWithSize:CGSizeMake(kScreenWidth - 114, 200)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:arrtDic
                                                  context:nil];
        
        CGFloat height = MAX(fram.size.height + 49 + 10, kTableViewRowHeight);
        
        //选中后，按照文字的高度，自定义单元格高度
        return height;
    } else {
        return kTableViewRowHeight;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![self.selectIndexPath isEqual:indexPath]) {
        self.selectIndexPath = indexPath;
        //刷新选中的cell
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
