//
//  BaseModel.m
//  Movie
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 无限互联. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self bulidRelationship:dic];
    }
    
    return self;
}

- (SEL)changeKeyToSetKey:(NSString *)key
{
    //1.首字母转成大写
    NSString *capStr = [key capitalizedString];
    
    //2.添加set字符串 对特殊名称 set HomeModel id 处理
    NSString *setKeyStr = nil;
    
    if ([key isEqualToString:@"id"]) {
        
        setKeyStr = [NSString stringWithFormat:@"set%@%@:", NSStringFromClass([self class]), capStr];
    } else {
        
        setKeyStr = [NSString stringWithFormat:@"set%@:", capStr];
    }
    
    //3.将字符串转换成方法
    return  NSSelectorFromString(setKeyStr);
}

- (void)bulidRelationship:(NSDictionary *)dic
{
    //1、获取所有的key
    //2、将key转换成set方法对应的setKey字符串
    //3、为setKey绑定真正能够调用的方法
    //4、把dic当中的value赋值给setKey
    
    //1.
    NSArray *allKeys = [dic allKeys];

    //绑定
    for (NSString *key in allKeys) {
        
        SEL method = [self changeKeyToSetKey:key];
        
       //4.
        id value = dic[key];
        
        if ([self respondsToSelector:method]) {
            
            [self performSelector:method withObject:value];
        }
    }
    
}

@end
