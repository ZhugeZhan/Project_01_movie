//
//  TabBarButton.h
//  Movie
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarButton : UIControl
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
}

//初始化TabBarButton
- (instancetype)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName withTitle:(NSString *)title;
//选中高亮
- (void)imageForSelected:(NSString *)imgName;

@end
