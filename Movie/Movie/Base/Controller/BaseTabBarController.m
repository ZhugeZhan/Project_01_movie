//
//  BaseTabBarController.m
//  Movie
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "BaseTabBarController.h"
#import "TabBarButton.h"

@interface BaseTabBarController ()
{
    UIImageView *_selectImage;
}
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义TabBar
    [self addButtonToTabBar];
    //创建子视图控制器
    [self creatViewControllers];
    
}




- (void)creatViewControllers {
    
    //先拿到所有的storyboard
    UIStoryboard *home = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UIStoryboard *news = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    UIStoryboard *top = [UIStoryboard storyboardWithName:@"Top" bundle:nil];
    UIStoryboard *cinema = [UIStoryboard storyboardWithName:@"Cinema" bundle:nil];
    UIStoryboard *more = [UIStoryboard storyboardWithName:@"More" bundle:nil];
    
    //拿到所有的viewController
    NSArray * viewCtrls = @[
                            [home instantiateInitialViewController],
                            [news instantiateInitialViewController],
                            [top instantiateInitialViewController],
                            [cinema instantiateInitialViewController],
                            [more instantiateInitialViewController]
                            ];
    //设置给self
    self.viewControllers = viewCtrls;
}



//清除系统的UITabbarButton，使用自己创建的子类
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    // 移除系统已有的按钮
    [self removeButtonFromTabBar];
    
}

- (void)removeButtonFromTabBar {
    // 获取TabBar上面的所有视图
    NSArray *subViews = self.tabBar.subviews;
    
    for (UIView *view in subViews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
    
}

- (void)addButtonToTabBar {
    
    float itemWith = kScreenWidth / 5;
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg_all"]];
    
    //1、设置选中的效果
    _selectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectTabbar_bg_all1"]];
    _selectImage.frame = CGRectMake(0, 2, 48, 45);
    [self.tabBar addSubview:_selectImage];
    
    //2、获取button的图片和名称
    NSArray *nameArr = @[@"电影",@"新闻",@"TOP",@"影院",@"更多"];
    NSArray *imageArr = @[
                          @"movie_home",
                          @"msg_new",
                          @"start_top250",
                          @"icon_cinema",
                          @"more_setting"
                          ];
    
    for (int i = 0; i < nameArr.count; i++) {
        NSString *title = nameArr[i];
        NSString *imgName = imageArr[i];
        
        TabBarButton *itemButton = [[TabBarButton alloc] initWithFrame:CGRectMake(i * itemWith, 0, itemWith, 49) withImageName:imgName withTitle:title];
        [itemButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        itemButton.tag = 1000 + i;
        
        [self.tabBar addSubview:itemButton];
    }
    
    //3、初始时选中框的位置
    _selectImage.center = [self.tabBar viewWithTag:1000].center;
    
}


- (void)buttonAction:(TabBarButton *)sender
{
    self.selectedIndex = sender.tag - 1000;
    
    [UIView animateWithDuration:.25 animations:^{
        _selectImage.center = sender.center;
    }];
    
    //home按钮选中状态的图片
    if (self.selectedIndex == 0) {
        [sender imageForSelected:@"movie_select_home"];
    } else {
        [[self.tabBar viewWithTag:1000] imageForSelected:@"movie_home"];
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
