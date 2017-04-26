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
#import "TimeLimitedTaskModel.h"

@interface TimeLimitedTaskDetailViewController ()

{
    AppDelegate *_delegate;
    
    NSTimer *_timer;
    
    NSInteger _leftTime;
    
    NSTimer *_timer1;
}

@property (nonatomic, strong) TaskInfoView * infoView;
@property (nonatomic, strong) TaskStepCopy * stepCopy;
@property (nonatomic, strong) TaskStepTimeLimited * timeLimited;

@property (nonatomic, strong) NSMutableDictionary * dataDic;

@property (nonatomic, strong) TimeLimitedTaskModel * timeLimitedTaskModel;

@property (nonatomic, assign) NSInteger extraTime;
@end

@implementation TimeLimitedTaskDetailViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titlestring = @"任务详情";
    [self setNavigationBar];
    [self requestDataWithType:_type];
    
    
    //app从后台变为活跃状态，执行观察者方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecameActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
    
    if ([_timer1 isValid]) {
        [_timer1 invalidate];
        _timer1 = nil;
    }
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
    
//    _leftTime = [self.dataDic[@"action_time"] integerValue];
    _leftTime = 180;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    
    [self.dataDic addEntriesFromDictionary:@{@"description": self.dataDic[@"guide"]}];
    self.infoView = [[TaskInfoView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 0)];
    self.infoView.dataDic = self.dataDic;
    [scrollView addSubview:self.infoView];
    
    self.stepCopy = [[TaskStepCopy alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.infoView.frame) + HeightScale(15), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) / 1.7)];
    self.stepCopy.dataDic = self.dataDic;
    [self.stepCopy.longPress addTarget:self action:@selector(longPress:)];
    [scrollView addSubview:self.stepCopy];
    
    self.timeLimited = [[TaskStepTimeLimited alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.stepCopy.frame) + HeightScale(15), SWIDTH - WidthScale(30), HeightScale(120))];
    self.timeLimited.receiveButton.enabled = NO;
    [self.timeLimited.receiveButton addTarget:self action:@selector(receiveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.timeLimited];
    
    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(self.timeLimited.frame) + HeightScale(20));

}

#pragma mark - 数据请求
- (void)requestDataWithType:(TaskType)type{
    NSString *url;
    switch (type) {
        case 1:
            url = KtimeLimitedTaskDetail;
            break;
        case 2:
            url = KunionTaskDetail;
            break;
        default:
            break;
    }
    NSDictionary *params = @{@"uid": _delegate.uid, @"appid": self.taskDic[@"appid"]};
    [RequestData PostDataWithURL:url parameters:params sucsess:^(id response) {
        DLog(@"%@", response);
        
        switch ([response[@"code"] intValue]) {
            case 1:
                
                //    time 服务器时间 - timec 用户点击时间 >  task_time 倒计时时间   ?  过期 : 倒计时
            {
                NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:response[@"data"]];
                
                NSInteger extraTime = [tempDic[@"task_time"] integerValue] - ([tempDic[@"time"] integerValue] - [tempDic[@"timec"] integerValue]);
                extraTime = extraTime > 0 ? extraTime : 0;
                [tempDic addEntriesFromDictionary:@{@"extraTime": @(extraTime)}];
                
                if (extraTime == 0) {
                    //任务已过期
                    [self cancelTaskWithType:type];
                } else {
                    self.dataDic = tempDic;
                    self.extraTime = [self.dataDic[@"extraTime"] integerValue];
                    _timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
                    
                    self.timeLimitedTaskModel = [TimeLimitedTaskModel yy_modelWithDictionary:self.dataDic];
                    
                    [self createUI];
                }
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

- (void)cancelTaskWithType:(TaskType)type{
    NSString *url;
    switch (type) {
        case 1:
            url = KtimeLimitedTaskCancel;
            break;
        case 2:
            url = KunionTaskCancel;
            break;
        default:
            break;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"任务已过期" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [RequestData PostDataWithURL:url parameters:@{@"uid": _delegate.uid, @"appid": self.taskDic[@"appid"]} sucsess:^(id response) {
            DLog(@"%@", response);
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } fail:^(NSError *error) {
            DLog(@"%@", error);
        } andViewController:self];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 事件处理
- (void)countDown{
    _extraTime -= 1;
    if (_extraTime != 0) {
        
        NSDictionary *firstDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:WidthScale(15)], NSFontAttributeName, [UIColor colorWithWhite:0.6 alpha:1], NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *firstStr = [[NSMutableAttributedString alloc] initWithString:@"任务剩余时间: " attributes:firstDic];
        NSDictionary *secondDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:WidthScale(15)], NSFontAttributeName,
                                   [UIColor blueColor],NSForegroundColorAttributeName,nil];
        NSMutableAttributedString *secondStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld", _extraTime] attributes:secondDic];
        [firstStr appendAttributedString:secondStr];
        self.infoView.timeLabel.attributedText = firstStr;
        
    } else {//倒计时结束
        [_timer invalidate];
        _timer = nil;
        
        [self cancelTaskWithType:_type];
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    DLog(@"复制关键词");
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    UILabel *nameLabel = (UILabel *)longPress.view;
    pasteboard.string = nameLabel.text;
    
    NSString *str = @"https://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?media=software";
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

- (void)didBecameActive{
    if (![_timer isValid] && ![self.timeLimited.receiveButton isEnabled]) {
        //计时器没有开始 并且 领取奖励按钮不能点击，则⬇️
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", self.timeLimitedTaskModel.pro]] options:@{} completionHandler:^(BOOL success){
            if (success) {
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
                [_timer setFireDate:[NSDate distantPast]];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"此设备未安装任务app，请参照步骤一安装后返回本页继续操作" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
}

- (void)timerMethod{
    if (_leftTime == 0) { //倒计时到0
        self.timeLimited.receiveButton.enabled = YES;
        self.timeLimited.receiveButton.backgroundColor = COLOR_RGB(24, 82, 222, 1);
        
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
        
        self.timeLimited.leftTimeLabel.attributedText = str1;
    }
}

- (void)receiveButtonClicked:(UIButton *)button{
    DLog(@"领取奖励");
    
    switch (_type) {
        case 1:
        {
            NSDictionary *params = @{@"uid": _delegate.uid, @"appid": self.taskDic[@"appid"]};
            [RequestData PostDataWithURL:KtimeLimitedTaskCommit parameters:params sucsess:^(id response) {
                DLog(@"%@", response);
                if ([response[@"code"] intValue] == 1) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:response[@"message"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            } fail:^(NSError *error) {
                DLog(@"%@", error);
            } andViewController:self];
        }
            
            break;
        case 2:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", self.timeLimitedTaskModel.pro]] options:@{} completionHandler:^(BOOL success){
                if (success) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }

            break;
        default:
            break;
    }

}


@end
