//
//  TopDetailHeaderModel.h
//  Movie
//
//  Created by ZhugeZhan on 16/4/9.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "BaseModel.h"

@interface TopDetailHeaderModel : BaseModel

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *titleCn;
@property (nonatomic, copy) NSString *titleEn;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray *videos;

@end
