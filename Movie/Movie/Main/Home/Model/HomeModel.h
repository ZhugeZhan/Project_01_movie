//
//  HomeModel.h
//  Movie
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface HomeModel : BaseModel

@property (nonatomic, strong) NSDictionary *rating;   //评分
@property (nonatomic, copy) NSString *year;           //年份
@property (nonatomic, copy) NSString *title;          //电影标题
@property (nonatomic, copy) NSString *original_title; //英文标题
@property (nonatomic, strong) NSDictionary *images;   //图片组

@end
