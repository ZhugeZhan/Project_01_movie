//
//  TopDetailViewController.h
//  Movie
//
//  Created by ZhugeZhan on 16/4/9.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "BaseViewController.h"
#import "TopDetailHeaderView.h"

@interface TopDetailViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>
{
    TopDetailHeaderView *_headerView;
}
@end
