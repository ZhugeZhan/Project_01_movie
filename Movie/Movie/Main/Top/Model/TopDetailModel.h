//
//  TopDetailModel.h
//  Movie
//
//  Created by ZhugeZhan on 16/4/9.
//  Copyright © 2016年 zhuge. All rights reserved.
//

/*
 {
 "userImage" : "http://img2.mtime.com/images/default/head.gif",
 "nickname" : "yangna988",
 "rating" : "9.0",
 "content" : "儿子很喜欢 一直期盼上映"
 },
 */

#import "BaseModel.h"

@interface TopDetailModel : BaseModel

@property (nonatomic, copy) NSString *userImage;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *content;

@end
