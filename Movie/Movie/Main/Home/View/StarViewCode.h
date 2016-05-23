//
//  StarViewCode.h
//  Movie
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarViewCode : UIView
{
    UIView *yellowView;
    UIView *grayView;
}

- (void)changeStarViewWidthWithRating:(float)rating;

@end
