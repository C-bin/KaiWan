//
//  TimeLimitedTaskDetailViewController.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TimeLimitedTaskDetailViewController.h"
#import "TaskInfoView.h"
#import "TaskStepCopy.h"
#import "TaskStepTimeLimited.h"

@interface TimeLimitedTaskDetailViewController ()

@property (nonatomic, strong) TaskInfoView * infoView;
@property (nonatomic, strong) TaskStepCopy * stepCopy;
@property (nonatomic, strong) TaskStepTimeLimited * timeLimited;

@end

@implementation TimeLimitedTaskDetailViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titlestring = @"任务详情";
    [self setNavigationBar];
    [self requestData];
}

- (void)createUI{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    self.infoView = [[TaskInfoView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 0)];
    [self.infoView.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImageUrl, self.taskDic[@"img"]]] placeholderImage:[UIImage imageNamed:@"列表-问号"]];
    [scrollView addSubview:self.infoView];
    
    self.stepCopy = [[TaskStepCopy alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.infoView.frame) + HeightScale(15), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) / 1.7)];
    [scrollView addSubview:self.stepCopy];
    
    self.timeLimited = [[TaskStepTimeLimited alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.stepCopy.frame) + HeightScale(15), SWIDTH - WidthScale(30), HeightScale(120))];
    [scrollView addSubview:self.timeLimited];
    
    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(self.timeLimited.frame) + HeightScale(20));

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)requestData{

}


@end
