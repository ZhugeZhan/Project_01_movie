//
//  PostView.m
//  Movie
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "PostView.h"

@implementation PostView

- (instancetype)init {
    
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self _createUI];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self _createUI];
}

// 获取到数据
- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    
    largeView.dataArray = _dataArray;
    smallView.dataArray = _dataArray;
    
    //开始时显示的titleLabel.text值
    [self changeTitleWithIndex:0];
}

- (void)_createUI {
    
    self.backgroundColor = [UIColor clearColor];
    
    //创建大海报视图
    [self _createLargeView];
    //创建头部视图
    [self _createHeaderView];
    //创建底部视图
    [self _createFooterView];
    //创建灯光效果
    [self _createLightView];
    
    //创建遮盖面板
    [self _createMaskView];
    
    //创建向下滑动事件
    [self _createGesture];
    
    [self bringSubviewToFront:headView];
    
    //大小collectionView互相观察
    [largeView addObserver:smallView forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:nil];
    
    [smallView addObserver:largeView forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:nil];
    
    //设置title的观察
    [largeView addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)_createHeaderView {
    
    UIImage *image = [UIImage imageNamed:@"indexBG_home"];
    image = [image stretchableImageWithLeftCapWidth:0 topCapHeight:2];
    headView = [[UIImageView alloc] initWithImage:image];
    headView.frame = CGRectMake(0, - kMovieSmallViewHeight - 5 , kScreenWidth, kHeaderHeight);
    headView.userInteractionEnabled = YES;
    
    [self addSubview:headView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((kScreenWidth-26) / 2, kHeaderHeight - 20, 26, 20);
    [button setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateSelected];
    button.tag = 100;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:button];
    
    //SmallLayout在这里被调用
    MovieLayout *layout = [[SmallLayout alloc] init];
    
    //SmallCollectionView在这里被调用
    smallView = [[SmallCollectionView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, kMovieSmallViewHeight) collectionViewLayout:layout];
    
    [headView addSubview:smallView];
}

- (void)_createLargeView {
    
    //LargeLayout在这里被调用
    MovieLayout *layout = [[LargeLayout alloc] init];
    
    //LargeCollectionView在这里被调用
    largeView = [[LargeCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49 - kFooterHeight) collectionViewLayout:layout];
    
    [self addSubview:largeView];
}

- (void)_createFooterView {
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight - 64 - 49 - kFooterHeight, kScreenWidth, kFooterHeight)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"poster_title_home"]];
    [self addSubview:titleLabel];
    
}

- (void)_createLightView {
    
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 124, 204)];
    left.image = [UIImage imageNamed:@"light"];
    
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 10 - 124, 5, 124, 204)];
    right.image = [UIImage imageNamed:@"light"];
    
    [self addSubview:left];
    [self addSubview:right];
}

// 创建遮盖面板，并且在遮盖面板上添加点击事件，
- (void)_createMaskView {
    
    maskView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    
    [maskView addTarget:self action:@selector(maskAction) forControlEvents:UIControlEventTouchUpInside];
    
    maskView.backgroundColor = [UIColor blackColor];
    
    maskView.alpha = 0;
    
    [self insertSubview:maskView belowSubview:headView];
}

// 向下滑动，调用button事件，改变遮盖面板的alphon值，使其显示
- (void)_createGesture {
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(maskAction)];
    
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self addGestureRecognizer:swipe];
}

//button点击事件
- (void)buttonAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    //界面下拉动画
    [UIView animateWithDuration:0.25 animations:^{
        headView.top = sender.selected ? 0 : (-kMovieSmallViewHeight - 5);
        maskView.alpha = sender.selected ? 0.6 : 0;
    }];
}

//点击和下滑事件，为了参数匹配，调用buttonAction:的时候需要传入一个button，相当于点击了上面定义的button
- (void)maskAction {
    //获取上面已经定义的在headView上Tag为100的button
    UIButton *button = (UIButton *)[headView viewWithTag:100];
    //调用点击事件
    [self buttonAction:button];
}

#pragma - mark KVO 改变title的值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSInteger index = [change[@"new"] integerValue];
    
    [self changeTitleWithIndex:index];
}

//切换底部的电影名
- (void)changeTitleWithIndex:(NSInteger)index {
    HomeModel *model = _dataArray[index];
    titleLabel.text = model.title;
}

@end

