//
//  LargeLayout.m
//  Movie
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "LargeLayout.h"

@implementation LargeLayout

- (instancetype)init
{
    if (self = [super init]) {
        //行与行的间距
        self.minimumLineSpacing = 40;
    }
    
    return self;
}

@end
