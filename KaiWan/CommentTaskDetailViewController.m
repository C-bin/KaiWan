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

@end

@implementation CommentTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titlestring = @"任务详情";
    [self setNavigationBar];
    [self requestData];
    
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
    
    self.stepCopy = [[TaskStepCopy alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.infoView.frame) + HeightScale(15), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) / 1.7)];
    self.stepCopy.dataDic = self.dataDic;
    [self.stepCopy.longPress addTarget:self action:@selector(longPress:)];
    [scrollView addSubview:self.stepCopy];
    
    self.stepComment = [[TaskStepComment alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.stepCopy.frame) + HeightScale(15), SWIDTH - WidthScale(30), (SWIDTH - WidthScale(30)) * 1.15)];
    self.stepComment.commitButton.enabled = NO;
    [self.stepComment.commitButton setBackgroundColor:[UIColor colorWithWhite:0.6 alpha:1]];
    [self.stepComment.tap addTarget:self action:@selector(tap:)];
    [self.stepComment.commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.stepComment];

    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(self.stepComment.frame) + HeightScale(20));
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
                
                NSInteger temp = ([tempDic[@"time"] integerValue] - [tempDic[@"timec"] integerValue]);
                NSInteger extraTime = temp > [tempDic[@"task_time"] integerValue] ? 0 : [tempDic[@"task_time"] integerValue];
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
        
        [self cancelTask];
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    UILabel *nameLabel = (UILabel *)longPress.view;
    pasteboard.string = nameLabel.text;
    
    NSString *str = [NSString stringWithFormat:
                     @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/search?mt=8&submit=edit&term=%@#software",
                     [self.commentTaskModel.keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)tap:(UITapGestureRecognizer *)tap{
    DLog(@"点此上传");
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)commitButtonClicked:(UIButton *)button{
    DLog(@"提交审核");
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
    
    
    [self.stepComment.commitButton setBackgroundColor:COLOR_RGB(24, 82, 222, 1)];
    self.stepComment.commitButton.enabled = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
