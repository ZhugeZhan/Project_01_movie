//
//  NewsModel.h
//  Movie
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 zhuge. All rights reserved.
//

/*
{
    "newsid" : 1491520,
    "type" : 0,
    "title" : "科幻大作《全面回忆》全新预告片发布",
    "summary" : "",
    "image" : "http://img31.mtime.cn/mg/2012/06/28/100820.21812355.jpg"
}
*/

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NewsType) {
    WordType,
    ImageType,
    VideoType
};

@interface NewsModel : NSObject

@property (nonatomic, assign) NSInteger newsid;
@property (nonatomic, assign) NewsType newsType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *image;

@end
