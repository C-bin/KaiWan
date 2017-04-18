//
//  HighTaskDetailViewController.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "HighTaskDetailViewController.h"
#import "TaskInfoView.h"
#import "TaskStepTutor.h"
#import "TaskStepCommit.h"

@interface HighTaskDetailViewController ()

@end

@implementation HighTaskDetailViewController

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
    
    TaskStepTutor *stepTutor = [[TaskStepTutor alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(infoView.frame) + HeightScale(15), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) * 1.05)];
    
    [scrollView addSubview:stepTutor];
    
    TaskStepCommit*stepCommit = [[TaskStepCommit alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(stepTutor.frame) + HeightScale(15), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) * 1.88)];
    [scrollView addSubview:stepCommit];
    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(stepCommit.frame) + HeightScale(20));

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
