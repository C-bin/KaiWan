//
//  HezuoViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/19.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "HezuoViewController.h"

@interface HezuoViewController ()

@end

@implementation HezuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"商务合作";
    [self setNavigationBar];
    [self creatUI];
    self.view.backgroundColor = [UIColor whiteColor];}
- (void)creatUI {
    UILabel *label = [UILabel creatLabelWithFont:15 andbgcolor:nil andtextColor:SF_COLOR(102, 102, 102) andAligment:0];
    label.text = @"    开玩是一款能赚钱的APP，用户主要通过完成任务来赚钱，每个任务会获得1-50元不等的现金奖励，获得的现金可以通过支付宝或微信直接提现，并且有签到赚钱，用户可以每天赚不停。平台当前有大量用户，可以进行app推广和广告展示等业务。";
    [self.view addSubview:label];
    //
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview.bottom).offset(HeightScale(30));
        make.left.equalTo(WidthScale(12));
        make.right.equalTo(-WidthScale(12));
    }];
    label.numberOfLines = 0;
    
    
    UILabel *label2 = [UILabel creatLabelWithFont:15 andbgcolor:nil andtextColor:SF_COLOR(102, 102, 102) andAligment:0];
    NSString *str = @"    如果合作意向，请联系：QQ：2170098306";
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:str];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(28, 108, 229) range:NSMakeRange(18, 10)];
    label2.attributedText = mstr;
    [self.view addSubview:label2];
    
    [label2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.bottom).offset(HeightScale(30));
        make.left.right.equalTo(label);
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
