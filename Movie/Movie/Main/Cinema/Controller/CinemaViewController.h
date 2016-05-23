//
//  CinemaViewController.h
//  Movie
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CinemaViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>
{
    /*
     {
     "name" : "东城区",
     "id" : "1029"
     }
     */
    NSArray *_districtArr; //地区
    
    /*
     {
     "lowPrice" : "40.00",
     "grade" : "8.8",
     "coord" : "116.36047,40.01433",
     "distance" : null,
     "address" : "北京市海淀区学清路甲8号，圣熙8号购物中心五层西侧。",
     "name" : "嘉华国际影城",
     "id" : "1396",
     "msg" : null,
     "districtId" : "1015",   //用来匹配地区
     "tel" : "010-82732228",
     "isSeatSupport" : "1",
     "isCouponSupport" : "1",
     "isImaxSupport" : "0",
     "isGroupBuySupport" : "0",
     "circleName" : "五道口"
     }
     */
    
    /*
     自定义出来的一个字典，根据不同的地区编号，存放影院
     {                    //_cinemaDic
     "1029" :             //key：districtId
     [                    //cinemaArr
     影院model1,           //model
     影院model2,
     影院model3,
     影院model4,
     影院model5
     ]
     }
     */
    NSMutableDictionary *_cinemaDic; //存放同一地区的影院
}
@end
