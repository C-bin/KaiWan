//
//  CommentTaskDetailViewController.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "CommentTaskDetailViewController.h"
#import "TaskInfoView.h"
#import "TaskStepCopy.h"
#import "TaskStepComment.h"

@interface CommentTaskDetailViewController ()

@end

@implementation CommentTaskDetailViewController

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
    
    TaskStepComment *stepComment = [[TaskStepComment alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(stepCopy.frame) + HeightScale(15), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) * 1.15)];
    [scrollView addSubview:stepComment];

    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(stepComment.frame) + HeightScale(20));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
