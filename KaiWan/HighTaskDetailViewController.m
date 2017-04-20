//
//  HighTaskDetailViewController.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "HighTaskDetailViewController.h"
#import "HighTaskWebViewController.h"
#import "TaskInfoView.h"
#import "TaskStepTutor.h"
#import "TaskStepCommit.h"
#import "HighTaskModel.h"

@interface HighTaskDetailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

{
    AppDelegate *_delegate;
}

@property (nonatomic, strong) TaskInfoView * infoView;
@property (nonatomic, strong) TaskStepTutor * stepTutor;
@property (nonatomic, strong) TaskStepCommit * stepCommit;

@property (nonatomic, strong) NSDictionary * dataDic;
@property (nonatomic, strong) HighTaskModel * highTaskModel;

@property (nonatomic, copy) NSString * mobileNumber;

@property (nonatomic, strong) NSMutableArray * imageForCommitArr;
@property (nonatomic, strong) UIImageView * currentImageView;

@property (nonatomic, strong) HighTaskWebViewController * highTaskWebVC;
@end

@implementation HighTaskDetailViewController

- (HighTaskWebViewController *)highTaskWebVC{
    if (!_highTaskWebVC) {
        _highTaskWebVC = [[HighTaskWebViewController alloc] init];
        self.highTaskWebVC.taskDic = self.dataDic;
    }
    return _highTaskWebVC;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _imageForCommitArr = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titlestring = @"任务详情";
    [self setNavigationBar];
    [self requestData];
    
}

- (void)dealloc{
    DLog(@"%s", __func__);
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
    
    NSArray *tutorImgArr = [self.dataDic[@"tutorial_map"] componentsSeparatedByString:@","];
    self.stepTutor = [[TaskStepTutor alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.infoView.frame) + HeightScale(15), SWIDTH - WidthScale(30), HeightScale(160) + (SWIDTH - WidthScale(60)) / 3 * tutorImgArr.count / 3)];
    self.stepTutor.tutorImgArr = tutorImgArr;
    [self.stepTutor.startButton addTarget:self action:@selector(startButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.stepTutor];
    
    
    NSArray *sampleImgArr = [self.dataDic[@"sample_diagram"] componentsSeparatedByString:@","];
    self.stepCommit = [[TaskStepCommit alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(self.stepTutor.frame) + HeightScale(15), SWIDTH - WidthScale(30), HeightScale(120) + ((SWIDTH - HeightScale(50)) / 2 * 1.5 + HeightScale(10)) * sampleImgArr.count)];
    self.stepCommit.sampleImgArr = sampleImgArr;
    self.stepCommit.commitButton.enabled = NO;
    [self.stepCommit.commitButton setBackgroundColor:[UIColor grayColor]];
    [self.stepCommit.commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.stepCommit];
    
    for (UITapGestureRecognizer *tap in self.stepCommit.tapGestureArr) {
        [tap addTarget:self action:@selector(tap:)];
    }
    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(self.stepCommit.frame) + HeightScale(20));

}



#pragma mark - 数据请求
- (void)requestData{
    NSDictionary *params = @{@"uid": @3, @"appid": self.taskDic[@"appid"]};
    [RequestData PostDataWithURL:KhighTaskDetail parameters:params sucsess:^(id response) {
        DLog(@"%@", response);
        switch ([response[@"code"] intValue]) {
            case 1:
                self.dataDic = response[@"data"];
                
                self.highTaskModel = [HighTaskModel yy_modelWithDictionary:self.dataDic];
                
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
- (void)startButtonClicked:(UIButton *)button{
    DLog(@"开始任务");
    
    if ([self.dataDic[@"is_mobile"] intValue] == 1 && self.mobileNumber.length != 11) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入您的手机号码" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            [textField addTarget:self action:@selector(mobileNumChanged:) forControlEvents:UIControlEventEditingChanged];
            
        }];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            DLog(@"确定");
            
            if (self.mobileNumber.length != 11 || ![self.mobileNumber hasPrefix:@"1"]) {
                UIAlertController *subAlert = [UIAlertController alertControllerWithTitle:nil message:@"请输入正确的手机号码" preferredStyle:UIAlertControllerStyleAlert];
                [subAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:subAlert animated:YES completion:nil];
            } else {
                [self.stepTutor.startButton setTitle:@"继续任务" forState:UIControlStateNormal];
                [self.navigationController pushViewController:self.highTaskWebVC animated:YES];
            }
            
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [self.navigationController pushViewController:self.highTaskWebVC animated:YES];
    }
}

- (void)mobileNumChanged:(UITextField *)textField{
    DLog(@"%@", textField.text);
    self.mobileNumber = textField.text;
}

- (void)commitButtonClicked:(UIButton *)button{
    DLog(@"提交审核");
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"uid": @3, @"appid": self.dataDic[@"appid"], @"mobile": self.mobileNumber ? self.mobileNumber : @""}];
    for (int i = 0; i < _imageForCommitArr.count; i ++) {
        [        params addEntriesFromDictionary:@{[NSString stringWithFormat:@"img[%d]", i]: [NSString stringWithFormat:@"data:image/png;base64,%@", [UIImageJPEGRepresentation(_imageForCommitArr[i], 0.2) base64EncodedStringWithOptions:0]]}];
    }
    
    [RequestData PostDataWithURL:KhighTaskCommit parameters:params sucsess:^(id response) {
        DLog(@"%@", response);
        if ([response[@"code"] intValue] == 1) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:response[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } fail:^(NSError *error) {
//        DLog(@"%@", error);
        DLog(@"出错");
    } andViewController:self];
}

- (void)tap:(UITapGestureRecognizer *)tap{
    DLog(@"%ld", tap.view.tag);
    
    _currentImageView = (UIImageView *)tap.view;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate Method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    DLog(@"%@", info);

    [_currentImageView setImage:info[@"UIImagePickerControllerOriginalImage"]];

    if ((_currentImageView.tag - 10) / 2 >= _imageForCommitArr.count) {
        //如果正在添加的图片位置大于或等于数组中图片个数，则把正在添加的图片加入到图片数组中
        [_imageForCommitArr addObject:_currentImageView.image];
    } else {
        //如果正在添加的图片位置小于数组中图片个数，则替换相应位置的图片为新添加的图片
        [_imageForCommitArr replaceObjectAtIndex:(_currentImageView.tag - 10) / 2 withObject:_currentImageView.image];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (_imageForCommitArr.count == self.stepCommit.sampleImgArr.count && [self.stepTutor.startButton.titleLabel.text isEqualToString:@"继续任务"]) {
            [self.stepCommit.commitButton setBackgroundColor:COLOR_RGB(24, 82, 222, 1)];
            self.stepCommit.commitButton.enabled = YES;
        }
        
    }];
    
}

@end
