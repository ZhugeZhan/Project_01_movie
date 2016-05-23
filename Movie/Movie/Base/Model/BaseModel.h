//
//  BaseModel.h
//  WXMovie
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 无限互联. All rights reserved.
//

/*
 从json文件中获取的数组中的每个字典转换成对应的model对象，此方法不够完善，不建议使用
 */



#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
