//
//  TimeLimitedTaskDetailViewController.h
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "MainCVViewController.h"

typedef NS_ENUM(NSUInteger, TaskType) {
    TaskTypeTimeLimited = 1, //限时任务
    TaskTypeUnion, //联盟任务
};

@interface TimeLimitedTaskDetailViewController : MainCVViewController

@property (nonatomic, strong) NSDictionary * taskDic;

@property (nonatomic, assign) TaskType type;

@end
