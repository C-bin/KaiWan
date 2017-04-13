//
//  DeepTaskDetailViewController.m
//  KaiWan
//
//  Created by van7ish on 2017/4/12.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "DeepTaskDetailViewController.h"
#import "TaskInfoView.h"
#import "TaskStepCopy.h"
#import "TaskStepDeep.h"

@interface DeepTaskDetailViewController ()

@end

@implementation DeepTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titlestring = @"任务详情";
    [self setNavigationBar];
    [self createUI];
    
}

- (void)createUI{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    TaskInfoView *infoView = [[TaskInfoView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 0)];
    [scrollView addSubview:infoView];

    TaskStepCopy *stepCopy = [[TaskStepCopy alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(infoView.frame) + HeightScale(15), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) / 1.7)];
    [scrollView addSubview:stepCopy];
    
    TaskStepDeep *stepDeep = [[TaskStepDeep alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(stepCopy.frame) + HeightScale(30), SWIDTH - WidthScale(30), stepCopy.frame.size.height)];
    [scrollView addSubview:stepDeep];
    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(stepDeep.frame) + HeightScale(30));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
