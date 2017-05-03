//
//  TaskStepCopy.h
//  KaiWan
//  好评任务、深度任务、限时任务 详情页 步骤一
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskStepCopy : UIView

@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * rankLabel;
@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UILongPressGestureRecognizer * longPress;

@property (nonatomic, strong) NSDictionary * dataDic;

@end
