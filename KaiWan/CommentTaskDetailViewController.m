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
#import "CommentTaskModel.h"

@interface CommentTaskDetailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

{
    AppDelegate *_delegate;
    NSTimer *_timer;
}

@property (nonatomic, strong) TaskInfoView * infoView;
@property (nonatomic, strong) TaskStepCopy * stepCopy;
@property (nonatomic, strong) TaskStepComment * stepComment;

@property (nonatomic, strong) NSDictionary * dataDic;

@property (nonatomic, strong) CommentTaskModel * commentTaskModel;

@property (nonatomic, strong) UIImageView * uploadImageView;
@property (nonatomic, assign) NSInteger extraTime;
@property (nonatomic, assign, getter=isTaskAppOpen) BOOL taskAppOpen;

@end

@implementation CommentTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titlestring = @"任务详情";
    [self setNavigationBar];
    [self requestData];
    
    //app从后台变为活跃状态，执行观察者方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecameActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

printViewControllerDealloc

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
    [scrollView addSubview:self.infoView];
    
    self.stepCopy = [[TaskStepCopy alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.infoView.frame) + HeightScale(18), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) / 1.65)];
    self.stepCopy.dataDic = self.dataDic;
    [self.stepCopy.longPress addTarget:self action:@selector(longPress:)];
    [scrollView addSubview:self.stepCopy];
    
    self.stepComment = [[TaskStepComment alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.stepCopy.frame) + HeightScale(18), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) * 1.18)];
    self.stepComment.commitButton.enabled = NO;
    [self.stepComment.commitButton setBackgroundColor:[UIColor colorWithWhite:0.6 alpha:1]];
    [self.stepComment.tap addTarget:self action:@selector(tap:)];
    [self.stepComment.commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.stepComment];

    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(self.stepComment.frame) + HeightScale(32));
}

#pragma mark - 数据请求
- (void)requestData{
    NSDictionary *params = @{@"uid": _delegate.uid, @"appid": self.taskDic[@"appid"]};
    [RequestData PostDataWithURL:KcommentTaskDetail parameters:params sucsess:^(id response) {
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
                    [self cancelTask];
                } else {
                    self.dataDic = tempDic;
                    self.extraTime = [self.dataDic[@"extraTime"] integerValue];
                    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
                    
                    self.commentTaskModel = [CommentTaskModel yy_modelWithDictionary:self.dataDic];
                    
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

- (void)cancelTask{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"任务已过期" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [RequestData PostDataWithURL:KcommentTaskCancel parameters:@{@"uid": _delegate.uid, @"appid": self.taskDic[@"appid"]} sucsess:^(id response) {
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
- (void)didBecameActive{
    if (![self isTaskAppOpen] && ![self.stepComment.commitButton isEnabled]) {
        //任务App没有打开 并且 领取奖励按钮不能点击，则⬇️
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", self.commentTaskModel.pro]] options:@{} completionHandler:^(BOOL success){
            if (success) {
                DLog(@"任务app打开了");
                [self setTaskAppOpen:YES];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"此设备未安装任务app，请参照步骤一安装后返回本页继续操作" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
}
- (void)countDown{
    _extraTime -= 1;
    if (_extraTime != 0) {
        
        NSDictionary *firstDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:WidthScale(13)], NSFontAttributeName, COLOR_RGB(194, 194, 194, 1), NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *firstStr = [[NSMutableAttributedString alloc] initWithString:@"任务剩余时间: " attributes:firstDic];
        NSDictionary *secondDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:WidthScale(15)], NSFontAttributeName,
                                   COLOR_RGB(138, 170, 239, 1),NSForegroundColorAttributeName,nil];
        
        NSInteger minite = _extraTime / 60;
        NSInteger second = _extraTime % 60;
        NSMutableAttributedString *secondStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld:%@", minite, second > 9 ? [NSString stringWithFormat:@"%ld", second] : [NSString stringWithFormat:@"0%ld", second]] attributes:secondDic];
        [firstStr appendAttributedString:secondStr];
        self.infoView.timeLabel.attributedText = firstStr;
        
    } else {//倒计时结束
        [_timer invalidate];
        _timer = nil;
        
        [self cancelTask];
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    UILabel *nameLabel = (UILabel *)longPress.view;
    pasteboard.string = nameLabel.text;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"已复制到剪贴板，是否打开App Store去下载?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *str = @"https://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?media=software";
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (void)tap:(UITapGestureRecognizer *)tap{
    DLog(@"点此上传");
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)commitButtonClicked:(UIButton *)button{
    DLog(@"提交审核");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"提交后不能修改，确定提交?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DLog(@"确定提交");
        [self requestCommit];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
    

}

- (void)requestCommit{
    NSDictionary *params = @{@"uid": _delegate.uid, @"appid": self.dataDic[@"appid"], @"img": [NSString stringWithFormat:@"data:image/png;base64,%@", [UIImageJPEGRepresentation(self.uploadImageView.image, 0.5) base64EncodedStringWithOptions:0]]};
    [RequestData PostDataWithURL:KcommentTaskCommit parameters:params sucsess:^(id response) {
        if ([response[@"code"] intValue] == 1) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:response[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:action];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    } fail:^(NSError *error) {
        DLog(@"%@", error);
    } andViewController:self];
}

#pragma mark - UIImagePickerDelegate Method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    DLog(@"%@", info);
    self.uploadImageView = (UIImageView *)[self.stepComment viewWithTag:11];
    self.uploadImageView.image = info[@"UIImagePickerControllerOriginalImage"];
    
    if ([self isTaskAppOpen]) {
        //任务app已经打开
        [self.stepComment.commitButton setBackgroundColor:COLOR_RGB(24, 82, 222, 1)];
        self.stepComment.commitButton.enabled = YES;
    }

    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (![_timer isValid]) {
            [_timer setFireDate:[NSDate distantPast]];
        }
    }];
}

@end
