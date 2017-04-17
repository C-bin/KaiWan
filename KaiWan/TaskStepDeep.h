//
//  TaskStepDeep.h
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DeepTaskModel;

@interface TaskStepDeep : UIView

@property (nonatomic, strong) UIButton * receiveButton;
@property (nonatomic, strong) UILabel * leftTimeLabel;

@property (nonatomic, strong) DeepTaskModel * deepTaskModel;

@end
