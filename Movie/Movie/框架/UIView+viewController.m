//
//  UIView+viewController.m
//  Movie
//
//  Created by ZhugeZhan on 16/4/21.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "UIView+viewController.h"

@implementation UIView (viewController)

//获取到最底层的viewController
- (UIViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    
    while (YES) {
        if ([next isKindOfClass:[UIViewController class]]) {
            break;
        } else {
            next = next.nextResponder;
        }
    }
    return (UIViewController *)next;
}

@end
