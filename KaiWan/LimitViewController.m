//
//  LimitViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/1.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "LimitViewController.h"

@interface LimitViewController ()
@property (nonatomic, strong)UIImageView *headicon;
@property (nonatomic, strong)UIImageView *bottomicon;
@property (nonatomic, strong)UILabel *titlelabel;
@property (nonatomic, strong)UILabel *timelabel;
@property (nonatomic, strong)UILabel *moneylabel;

@end

@implementation LimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titlestring = @"任务详情";
    [self setNavigationBar];
    [self creatUI];
    
}
- (void)creatUI {
    
    self.headicon = [[UIImageView alloc]init];
    [self.view addSubview:self.headicon];
    self.headicon.backgroundColor = [UIColor redColor];
    [self.headicon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview.bottom).offset([UIView setHeight:15]);
        make.left.equalTo([UIView setWidth:12]);
        make.width.and.height.equalTo([UIView setWidth:50]);
    }];
    
    self.titlelabel = [[UILabel alloc]init];
    self.titlelabel.font = [UIFont systemFontOfSize:16];
    self.titlelabel.textColor = [UIColor blackColor];
    [self.view addSubview:self.titlelabel];
    self.titlelabel.text = @"**闲置二手";
    [self.titlelabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headicon.right).offset([UIView setWidth:18]);
        make.top.equalTo(self.bgview.bottom).offset([UIView setHeight:25]);
    }];

    
    
    self.timelabel = [[UILabel alloc]init];
    self.timelabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.timelabel];
    self.timelabel.text = @"任务闲置时间：22：32";
    [self.timelabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headicon.right).offset([UIView setWidth:18]);
        make.top.equalTo(self.titlelabel.bottom).offset([UIView setHeight:8]);

    }];

    
    
    
    self.moneylabel = [[UILabel alloc]init];
    self.moneylabel.textColor = SF_COLOR(219, 3, 3);
    [self.view addSubview:self.moneylabel];
    self.moneylabel.text = @"+232元";
    [self.moneylabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right).offset(-[UIView setWidth:12]);
        make.top.equalTo(self.bgview.bottom).offset([UIView setHeight:34]);
    }];

    
    UILabel *linelabel = [[UILabel alloc]init];
    linelabel.backgroundColor = SF_COLOR(211, 211, 211);
    [self.view addSubview:linelabel];
    [linelabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(-[UIView setWidth:12]);
        make.top.equalTo(self.bgview.bottom).equalTo([UIView setHeight:83]);
        make.width.equalTo([UIView setWidth:375-2*12]);
        make.height.equalTo(0.5);
    }];

    
    UILabel *canlabel = [[UILabel alloc]init];
    canlabel.textColor = SF_COLOR(50, 50, 50);
    canlabel.font = [UIFont systemFontOfSize:16];
    canlabel.text = @"参与步骤:";
    [self.view addSubview:canlabel];
    [canlabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linelabel.bottom).offset([UIView setHeight:18]);
        make.left.equalTo([UIView setWidth:12]);
    }];

    UILabel *blabel = [[UILabel alloc]init];
    blabel.textColor = SF_COLOR(102, 102, 102);
    blabel.font = [UIFont systemFontOfSize:15];
    blabel.lineBreakMode = NSLineBreakByWordWrapping;
    blabel.numberOfLines = 0;
    blabel.text = @"1.复制下方关键词，在App Store搜索下载，找到夏眠对应图标，约在第3名下载";
    [self.view addSubview:blabel];
    
    [blabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([UIView setWidth:12]);
        make.top.equalTo(canlabel.bottom).offset([UIView setHeight:16]);
        make.width.equalTo([UIView setWidth:375-24]);
    }];
    
    
    UILabel *clabel = [[UILabel alloc]init];
    clabel.textColor = SF_COLOR(102, 102, 102);
    clabel.font = [UIFont systemFontOfSize:15];
    clabel.lineBreakMode = NSLineBreakByWordWrapping;
    clabel.numberOfLines = 0;
    clabel.text = @"2.下载成功后，打开试玩3分钟";
    [self.view addSubview:clabel];

    [clabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([UIView setWidth:12]);
        make.top.equalTo(blabel.bottom).offset([UIView setHeight:14]);
    }];
    
    UILabel *dlabel = [[UILabel alloc]init];
    dlabel.textColor = SF_COLOR(102, 102, 102);
    dlabel.font = [UIFont systemFontOfSize:15];
    dlabel.lineBreakMode = NSLineBreakByWordWrapping;
    dlabel.numberOfLines = 0;
    dlabel.text = @"2.下载成功后，打开试玩3分钟";
    [self.view addSubview:dlabel];
    
    [dlabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([UIView setWidth:12]);
        make.top.equalTo(clabel.bottom).offset([UIView setHeight:14]);
    }];
    
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
