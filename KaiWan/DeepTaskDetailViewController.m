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
#import "DeepTaskModel.h"

@interface DeepTaskDetailViewController ()

@property (nonatomic, strong) TaskInfoView * infoView;
@property (nonatomic, strong) TaskStepCopy * stepCopy;
@property (nonatomic, strong) TaskStepDeep * stepDeep;

@property (nonatomic, strong) NSDictionary * dataDic;

@end

@implementation DeepTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titlestring = @"任务详情";
    [self setNavigationBar];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)createUI{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    self.infoView = [[TaskInfoView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 0)];
    DeepTaskModel *deepTaskModel = [DeepTaskModel yy_modelWithDictionary:self.dataDic];
    self.infoView.deepTaskModel = deepTaskModel;
    [scrollView addSubview:self.infoView];
    

    self.stepCopy = [[TaskStepCopy alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.infoView.frame) + HeightScale(15), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) / 1.7)];
    [self.stepCopy.longPress addTarget:self action:@selector(longPress:)];
    [scrollView addSubview:self.stepCopy];
    
    self.stepDeep = [[TaskStepDeep alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.stepCopy.frame) + HeightScale(15), SWIDTH - WidthScale(30), self.stepCopy.frame.size.height)];
    [scrollView addSubview:self.stepDeep];
    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(self.stepDeep.frame) + HeightScale(20));
    
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    DLog(@"复制关键词");
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    UILabel *nameLabel = (UILabel *)longPress.view;
    pasteboard.string = nameLabel.text;
}

- (void)requestData{
    NSDictionary *params = @{@"uid":@3, @"id":@2};
    [RequestData PostDataWithURL:KdeepTaskDetailUrl parameters:params sucsess:^(id response) {
        DLog(@"%@", response);
        
        self.dataDic = response[@"data"];
        
        [self createUI];
        
    } fail:^(NSError *error) {
        DLog(@"%@", error);
        
    } andViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
