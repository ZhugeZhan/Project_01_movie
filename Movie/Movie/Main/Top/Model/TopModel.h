//
//  TopModel.h
//  Movie
//
//  Created by ZhugeZhan on 16/4/8.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopModel : NSObject

@property(nonatomic, strong)NSDictionary *rating; //评分
@property(nonatomic, strong)NSDictionary *images; //图片
@property(nonatomic, copy)NSString *title; //标题
@property(nonatomic, copy)NSString *year; //年份

@end
