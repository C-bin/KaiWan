//
//  TaskStepCopy.h
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DeepTaskModel;

@interface TaskStepCopy : UIView

@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * rankLabel;
@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UILongPressGestureRecognizer * longPress;

@property (nonatomic, strong) DeepTaskModel * deepTaskModel;

@end
