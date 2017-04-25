//
//  ShowListViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "ShowListViewController.h"

@interface ShowListViewController ()
@property (nonatomic,strong) UILabel *moneyLabel;

@end

@implementation ShowListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"成绩单";
    [self setNavigationBar];
    [self creatUI];
    [self request];
}
- (void)request {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Share/bask.html?uid=%@",HostUrl,del.uid] parameters:nil sucsess:^(id response) {
        NSDictionary *dic =  (NSDictionary *)response;
        NSDictionary *data = dic[@"data"];
        NSString *days = [NSString stringWithFormat:@"注册天数：%@天",data[@"days"]];
        NSString *task_count = [NSString stringWithFormat:@"试玩应用：%@个",data[@"task_count"]];
        NSString *task_money = [NSString stringWithFormat:@"试玩收入:%@元",data[@"task_money"]];
        NSString *invite_count = [NSString stringWithFormat:@"徒弟个数:%@个",data[@"invite_count"]];
        NSString *invite_money = [NSString stringWithFormat:@"徒弟收入:%@元",data[@"invite_money"]];
        NSArray *arr = @[days,task_count,task_money,invite_count,invite_money];
        for (int i = 0; i < 5; i++) {
            UILabel *label = (UILabel *)[self.view viewWithTag:290+i];
            label.text = arr[i];
        }
        _moneyLabel.text = [NSString stringWithFormat:@"%@元",data[@"money_all"]];

        
    } fail:^(NSError *error) {
        
    } andViewController:self];
}
- (void)creatUI {
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"成绩背景"]];
    [self.view addSubview:image];
    
    [image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([UIView setHeight:15]);
        make.centerX.equalTo(0);
        make.top.equalTo(self.bgview.bottom).offset([UIView setHeight:32]);
        make.height.equalTo([UIView setHeight:434]);
    }];
    
    UIButton *btn = [UIButton creatButtonWithTitle:@"晒出成绩单" andBgColor:SF_COLOR(28, 108, 229) andTextColor:SF_COLOR(255, 255, 255) andtitleFont:23];
    [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.layer.cornerRadius = 10;
    btn.clipsToBounds = YES;
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image.bottom).offset([UIView setHeight:39]);
        make.width.equalTo([UIView setWidth:294]);
        make.centerX.equalTo(0);
        make.height.equalTo([UIView setHeight:44]);
    }];
//    NSArray *titlearr = @[@"注册天数：31天",@"试玩应用：3个",@"试玩收入：32元",@"徒弟个数：12个",@"徒弟收入：23元"];
    UIView *lastview = nil;
    for (int i = 0; i < 5; i++) {
        UILabel *label = [UILabel creatLabelWithFont:18 andbgcolor:nil andtextColor:SF_COLOR(255, 255, 255) andAligment:NSTextAlignmentCenter];
        label.tag = 290+i;
//        label.text = titlearr[i];
        [image addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            if (lastview) {
                make.top.equalTo(lastview.top).equalTo(HeightScale(30));
            }else {
                make.top.equalTo(image.top).equalTo(HeightScale(120));
            }
            make.centerX.equalTo(0);
        }];
        lastview = label;
    }
    
    UILabel *zlabel = [UILabel creatLabelWithFont:15 andbgcolor:nil andtextColor:SF_COLOR(255, 255, 255) andAligment:NSTextAlignmentCenter];
    [image addSubview:zlabel];
    zlabel.text = @"累计收入";
    [zlabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastview.bottom).offset(HeightScale(36));
        make.centerX.equalTo(0);
    }];
    
    self.moneyLabel = [UILabel creatLabelWithFont:24 andbgcolor:nil andtextColor:SF_COLOR(255, 255, 255) andAligment:NSTextAlignmentCenter];
    [image addSubview:self.moneyLabel];
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zlabel.top).offset(HeightScale(27));
        make.centerX.equalTo(0);
        
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
