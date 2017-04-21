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
}

@property (nonatomic, strong) TaskInfoView * infoView;
@property (nonatomic, strong) TaskStepCopy * stepCopy;
@property (nonatomic, strong) TaskStepComment * stepComment;

@property (nonatomic, strong) NSDictionary * dataDic;

@property (nonatomic, strong) CommentTaskModel * commentTaskModel;

@property (nonatomic, strong) UIImageView * uploadImageView;

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
    [self.stepComment.tap addTarget:self action:@selector(tap:)];
    [self.stepComment.commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.stepComment];

    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(self.stepComment.frame) + HeightScale(20));
}

#pragma mark - 数据请求
- (void)requestData{
    NSDictionary *params = @{@"uid": @3, @"appid": self.taskDic[@"appid"]};
    [RequestData PostDataWithURL:KcommentTaskDetail parameters:params sucsess:^(id response) {
        DLog(@"%@", response);
        switch ([response[@"code"] intValue]) {
            case 1:
                self.dataDic = response[@"data"];
                
                self.commentTaskModel = [CommentTaskModel yy_modelWithDictionary:self.dataDic];
                
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

#pragma mark - 事件处理
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
    NSDictionary *params = @{@"uid": @3, @"appid": self.dataDic[@"appid"], @"img": [NSString stringWithFormat:@"data:image/png;base64,%@", [UIImageJPEGRepresentation(self.uploadImageView.image, 0.5) base64EncodedStringWithOptions:0]]};
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
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
