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
    
    NSTimer *_timer;
    
    NSInteger _leftTime;
}

@property (nonatomic, strong) TaskInfoView * infoView;
@property (nonatomic, strong) TaskStepCopy * stepCopy;
@property (nonatomic, strong) TaskStepDeep * stepDeep;

@property (nonatomic, strong) NSDictionary * dataDic;

@property (nonatomic, strong) DeepTaskModel * deepTaskModel;

@end

@implementation DeepTaskDetailViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titlestring = @"任务详情";
    [self setNavigationBar];
    
    _leftTime = 180;
    
    //app从后台变为活跃状态，执行观察者方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecameActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)viewDidDisappear:(BOOL)animated{
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
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
    [self.infoView.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImageUrl, self.taskDic[@"img"]]] placeholderImage:[UIImage imageNamed:@"列表-问号"]];
    [scrollView addSubview:self.infoView];
    
    self.stepCopy = [[TaskStepCopy alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.infoView.frame) + HeightScale(15), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) / 1.7)];
    self.stepCopy.dataDic = self.dataDic;
    [self.stepCopy.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImageUrl, self.taskDic[@"img"]]] placeholderImage:[UIImage imageNamed:@"列表-问号"]];
    [self.stepCopy.longPress addTarget:self action:@selector(longPress:)];
    [scrollView addSubview:self.stepCopy];
    
    self.stepDeep = [[TaskStepDeep alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.stepCopy.frame) + HeightScale(15), SWIDTH - WidthScale(30), self.stepCopy.frame.size.height)];
    self.stepDeep.deepTaskModel = self.deepTaskModel;
    self.stepDeep.receiveButton.enabled = NO;
    self.stepDeep.receiveButton.backgroundColor = [UIColor grayColor];
    [self.stepDeep.receiveButton addTarget:self action:@selector(receiveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.stepDeep];
    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(self.stepDeep.frame) + HeightScale(20));
    
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
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:response[@"message"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    } fail:^(NSError *error) {
        DLog(@"%@", error);
    } andViewController:self];
}

#pragma mark - 事件处理
- (void)receiveButtonClicked:(UIButton *)button{
    DLog(@"领取奖励");
    
    [self taskCommit];
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    DLog(@"复制关键词");
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    UILabel *nameLabel = (UILabel *)longPress.view;
    pasteboard.string = nameLabel.text;
    
    NSString *str = [NSString stringWithFormat:
                     @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/search?mt=8&submit=edit&term=%@#software",
                     [self.deepTaskModel.keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}

- (void)didBecameActive{
    BOOL Y = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", self.deepTaskModel.pro]]];
    if (Y && ![_timer isValid]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"此设备已安装任务app，现在打开" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", self.deepTaskModel.pro]] options:@{} completionHandler:^(BOOL success){
                if (success) {
                    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
                    [_timer setFireDate:[NSDate distantPast]];
                }
            }];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"此设备未安装任务app，请参照步骤一安装后返回本页继续操作" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)timerMethod{
    if (_leftTime == 0) { //倒计时到0
        self.stepDeep.receiveButton.enabled = YES;
        self.stepDeep.receiveButton.backgroundColor = COLOR_RGB(24, 82, 222, 1);
        
        if ([_timer isValid]) {
            [_timer invalidate];
        }
        _timer = nil;
        
    } else {
        _leftTime -= 1;
        
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"试玩3分钟 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(13)], NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:1]}];
        
        NSInteger minite, second;
        minite = _leftTime / 60;
        second = _leftTime % 60;
        
        NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld:%@", minite, second > 9 ? [NSString stringWithFormat:@"%ld", second] : [NSString stringWithFormat:@"0%ld", second]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(13)], NSForegroundColorAttributeName:[UIColor redColor]}];
        
        [str1 appendAttributedString:str2];
        
        self.stepDeep.leftTimeLabel.attributedText = str1;
    }
}


@end
