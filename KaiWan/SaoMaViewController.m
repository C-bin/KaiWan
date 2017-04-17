//
//  SaoMaViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "SaoMaViewController.h"

@interface SaoMaViewController ()
@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic,strong) UILabel *nickNameLabel;
@property (nonatomic,strong) UILabel *idLabel;
@property (nonatomic,strong) UIImageView *qcodeImage;

@end

@implementation SaoMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.titlestring = @"扫码收徒";
    [self setNavigationBar];
    [self creatUI];
    self.view.backgroundColor = [UIColor whiteColor];}
- (void)creatUI {
    self.headImage = [[UIImageView alloc]init];
    _headImage.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.headImage];
    [self.headImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview.bottom).offset(HeightScale(24));
        make.centerX.equalTo(0);
        make.height.with.width.equalTo(HeightScale(105));
    }];
    _headImage.layer.cornerRadius = HeightScale(105/2.0);
    _headImage.clipsToBounds = YES;
    
    
    self.nickNameLabel = [UILabel creatLabelWithFont:18 andbgcolor:nil andtextColor:SF_COLOR(0, 0, 0) andAligment:NSTextAlignmentCenter];
    _nickNameLabel.text = @"其透气啊";
    [self.view addSubview:self.nickNameLabel];
    
    [self.nickNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImage.bottom).offset(HeightScale(10));
        make.centerX.equalTo(0);
    }];
    
    self.idLabel = [UILabel creatLabelWithFont:14 andbgcolor:nil andtextColor:SF_COLOR(124, 124, 124) andAligment:NSTextAlignmentCenter];
    self.idLabel.text = @"ID:1231";
    [self.view addSubview:self.idLabel];
    
    [self.idLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.top).offset(HeightScale(26));
        make.centerX.equalTo(0);
    }];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"扫码背景"]];
    [self.view addSubview:image];
    [image makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idLabel.bottom).offset(HeightScale(42));
        make.centerX.equalTo(0);
        make.width.equalTo(WidthScale(340));
        make.height.equalTo(HeightScale(237));
    }];

    self.qcodeImage = [[UIImageView alloc]init];
    self.qcodeImage.backgroundColor = [UIColor redColor];
    [image addSubview:self.qcodeImage];
    
    [self.qcodeImage makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(HeightScale(83));
        make.width.equalTo(WidthScale(108));
        make.height.equalTo(HeightScale(108));
    }];
    
    UIButton *btn = [UIButton creatButtonWithTitle:@"晒出成绩单" andBgColor:SF_COLOR(28, 108, 229) andTextColor:SF_COLOR(255, 255, 255) andtitleFont:23];
    [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.layer.cornerRadius = 10;
    btn.clipsToBounds = YES;
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image.bottom).offset([UIView setHeight:56]);
        make.width.equalTo([UIView setWidth:294]);
        make.centerX.equalTo(0);
        make.height.equalTo([UIView setHeight:44]);
    }];
}
- (void)shareClick:(UIButton *)btn {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
