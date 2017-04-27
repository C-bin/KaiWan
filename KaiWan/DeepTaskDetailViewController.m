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
#import <sys/sysctl.h>

@interface DeepTaskDetailViewController ()

{
    AppDelegate *_delegate;
}

@property (nonatomic, strong) TaskInfoView * infoView;
@property (nonatomic, strong) TaskStepCopy * stepCopy;
@property (nonatomic, strong) TaskStepDeep * stepDeep;

@property (nonatomic, strong) NSDictionary * dataDic;

@property (nonatomic, strong) DeepTaskModel * deepTaskModel;
@property (nonatomic, assign, getter=isTaskAppOpen) BOOL taskAppOpen;

@end

@implementation DeepTaskDetailViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titlestring = @"任务详情";
    [self setNavigationBar];

    [self requestData];
    
}

- (void)dealloc{
    DLog(@"%s", __func__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 创建UI
- (void)createUI{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    self.infoView = [[TaskInfoView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 0)];
    self.infoView.dataDic = self.dataDic;
    self.infoView.timeLabel.hidden = YES;
    [self.infoView.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImageUrl, self.taskDic[@"img"]]] placeholderImage:[UIImage imageNamed:@"列表-问号"]];
    [scrollView addSubview:self.infoView];
    
    self.stepCopy = [[TaskStepCopy alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.infoView.frame) + HeightScale(18), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) / 1.65)];
    self.stepCopy.dataDic = self.dataDic;
    [self.stepCopy.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImageUrl, self.taskDic[@"img"]]] placeholderImage:[UIImage imageNamed:@"列表-问号"]];
    [self.stepCopy.longPress addTarget:self action:@selector(longPress:)];
    [scrollView addSubview:self.stepCopy];
    
    self.stepDeep = [[TaskStepDeep alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.stepCopy.frame) + HeightScale(18), SWIDTH - WidthScale(30), self.stepCopy.frame.size.height - HeightScale(10))];
    self.stepDeep.deepTaskModel = self.deepTaskModel;
    self.stepDeep.receiveButton.enabled = NO;
    self.stepDeep.receiveButton.backgroundColor = [UIColor grayColor];
    [self.stepDeep.receiveButton addTarget:self action:@selector(receiveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.stepDeep];
    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(self.stepDeep.frame) + HeightScale(32));
    
}

#pragma mark - 数据请求
- (void)requestData{
    NSDictionary *params = @{@"uid": _delegate.uid, @"id": self.taskDic[@"id"]};
    [RequestData PostDataWithURL:KdeepTaskDetailUrl parameters:params sucsess:^(id response) {
        DLog(@"%@", response);
        
        switch ([response[@"code"] intValue]) {
            case 1:
                self.dataDic = response[@"data"];
                
                self.deepTaskModel = [DeepTaskModel yy_modelWithDictionary:self.dataDic];
                
                [self createUI];
                
                if ([self.dataDic[@"is_click"] intValue] == 1) {
                    //可以点击
                    self.stepDeep.receiveButton.enabled = YES;
                    [self.stepDeep.receiveButton setBackgroundColor:BGColorForButton];
                }
                break;
            default:
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:response[@"message"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
                break;
        }

        
    } fail:^(NSError *error) {
        DLog(@"%@", error);
        
    } andViewController:self];
}

- (void)taskCommit{
    NSDictionary *params = @{@"uid": _delegate.uid, @"id": self.taskDic[@"id"]};
    [RequestData PostDataWithURL:KdeepTaskCommit parameters:params sucsess:^(id response) {
        if ([response[@"code"] intValue] == 1) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"今天任务已完成，请明天再来" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:response[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:alertAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
    } fail:^(NSError *error) {
        DLog(@"%@", error);
    } andViewController:self];
}

#pragma mark - 事件处理
- (void)receiveButtonClicked:(UIButton *)button{
    DLog(@"领取奖励");
    
    [self openTaskApp];
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    DLog(@"复制关键词");
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    UILabel *nameLabel = (UILabel *)longPress.view;
    pasteboard.string = nameLabel.text;
    
    NSString *str = @"https://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?media=software";
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}

- (void)openTaskApp{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", self.deepTaskModel.pro]] options:@{} completionHandler:^(BOOL success){
            if (success) {
                
                [self taskCommit];

            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"此设备未安装任务app，请参照步骤一安装后返回本页继续操作" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];

}

@end
