//
//  SectionHeaderView.h
//  Movie
//
//  Created by ZhugeZhan on 16/4/21.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSectionHeaderHeight 35

@interface SectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak, readonly)UIControl *ctrlView;
@property (nonatomic, weak, readonly)UILabel *titleLabel;

@end
