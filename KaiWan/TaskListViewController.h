//
//  TaskListViewController.h
//  KaiWan 
//
//  Created by van7ish on 2017/4/24.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "MainCVViewController.h"

typedef NS_ENUM(NSInteger, TaskTag) {
    TaskTagTimeLimited = 0,
    TaskTagComment,
    TaskTagUnion,
    TaskTagDeep,
    TaskTagHigh
};

@interface TaskListViewController : MainCVViewController

@property (nonatomic, assign) TaskTag taskTag;

@end
