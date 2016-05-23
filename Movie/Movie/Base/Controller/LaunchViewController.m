//
//  LaunchViewController.m
//  Movie
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "LaunchViewController.h"
#import "BaseTabBarController.h"

@interface LaunchViewController () 

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _createUI];
}

- (void)_createUI {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    //分页滑动
    scrollView.pagingEnabled = YES;
    
    scrollView.contentSize = CGSizeMake(5 * kScreenWidth, kScreenHeight);
    
    //水平方向不显示滑动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.delegate = self;
    
    for (int i = 0; i < 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"guide%d", i + 1];
        NSString *progressImageName = [NSString stringWithFormat:@"guideProgress%d", i + 1];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageView.image = [UIImage imageNamed:imageName];
        
        UIImageView *progressImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:progressImageName]];
        progressImageView.frame = CGRectMake((kScreenWidth - progressImageView.image.size.width) / 2, kScreenHeight - 50, progressImageView.image.size.width, progressImageView.image.size.height);
        
        [imageView addSubview:progressImageView];
        [scrollView addSubview:imageView];
        
    }
    
    [self.view addSubview:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == kScreenWidth * 4) {
        
        BaseTabBarController *root = [[BaseTabBarController alloc] init];
        
        //转场
        [UIView transitionWithView:self.view.window duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.view.window.rootViewController = root;
        } completion:^(BOOL finished) {
            
        }];
    
    }
}


// 状态栏隐藏
- (BOOL)prefersStatusBarHidden
{
    return YES;
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
