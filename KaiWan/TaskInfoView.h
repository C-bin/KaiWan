//
//  TaskInfoView.h
//  KaiWan
//  任务详情页第一栏
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskInfoView : UIView

@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) UILabel * stepLabel;

@property (nonatomic, strong) NSDictionary * dataDic;

@end
