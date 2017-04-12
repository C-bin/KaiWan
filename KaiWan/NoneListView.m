//
//  NoneListView.m
//  KaiWan
//
//  Created by chenguang on 17/4/12.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "NoneListView.h"
//暂无记录试图
@implementation NoneListView

+ (UIView *)creatNoneListViewWith:(UIScrollView *)sv {
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, sv.bounds.size.width/2, sv.bounds.size.height/2);
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"暂无记录"]];
    [view addSubview:image];
    [image makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(CGSizeMake(sv.bounds.size.width/2, sv.bounds.size.height/2));
        make.width.equalTo([UIView setWidth:180]);
        make.height.equalTo([UIView setHeight:160]);
    }];
    
    return view;
    
}

@end
