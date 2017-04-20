//
//  OurViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/19.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "OurViewController.h"

@interface OurViewController ()

@end

@implementation OurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"关于我们";
    [self setNavigationBar];
    [self creatUI];
    self.view.backgroundColor = [UIColor whiteColor];
}
/*
 一，开玩介绍
 开玩是一款能赚钱的APP，用户主要通过完成任务来赚钱，每个任务会获得1-50元不等的现金奖励，获得的现金可以通过支付宝或微信直接体现，并且有签到赚钱，用户可以每天赚不停。
 二，关于赚钱
 1，APP试玩：每个试玩奖励1-3元不等。
 2，邀请奖励：邀请一个好友，最多可得5元奖励。
 3，活动收入：平台会定期举办各种各样的活动，活动期间不仅有丰厚的试玩收益，还有大量现金大奖等你来拿。
 4，其他：一元夺宝、签到赚钱等让你在任务之余也能轻松赚钱！
 三、关于作弊处理
 一旦发现刷机等作弊方式，账号会被系统立即禁用。如果正常用户被“误禁”，可联系客服进行解决，一旦采信，我们将重新恢复禁用的账号，之前所有收入不会受到影响。
 */
- (void)creatUI {
    UILabel *title1 = [UILabel creatLabelWithFont:17 andbgcolor:nil andtextColor:SF_COLOR(51, 51, 51) andAligment:0];
    title1.text = @"一、开玩介绍";
    [self.view addSubview:title1];
    [title1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview.bottom).offset(HeightScale(30));
        make.left.equalTo(WidthScale(12));
        make.right.equalTo(-WidthScale(12));
    }];
    
    UILabel *label = [UILabel creatLabelWithFont:15 andbgcolor:nil andtextColor:SF_COLOR(102, 102, 102) andAligment:0];
    label.text = @"   开玩是一款能赚钱的APP，用户主要通过完成任务来赚钱，每个任务会获得1-50元不等的现金奖励，获得的现金可以通过支付宝或微信直接体现，并且有签到赚钱，用户可以每天赚不停。";
    [self.view addSubview:label];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.bottom).offset(HeightScale(3));
        make.left.right.equalTo(title1);
    }];
    
    UILabel *title2 = [UILabel creatLabelWithFont:17 andbgcolor:nil andtextColor:SF_COLOR(51, 51, 51) andAligment:0];
    title2.text = @"二、关于赚钱";
    [self.view addSubview:title2];
    [title2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.bottom).offset(HeightScale(24));
        make.left.right.equalTo(label);
    }];
    
    UILabel *label2 = [UILabel creatLabelWithFont:15 andbgcolor:nil andtextColor:SF_COLOR(102, 102, 102) andAligment:0];
    label2.text = @"      1，APP试玩：每个试玩奖励1-3元不等。\n      2，邀请奖励：邀请一个好友，最多可得5元奖励。\n      3，活动收入：平台会定期举办各种各样的活动，活动期间不仅有丰厚的试玩收益，还有大量现金大奖等你来拿。\n      4，其他：一元夺宝、签到赚钱等让你在任务之余也能轻松赚钱";
    [self.view addSubview:label2];
    [label2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.bottom).offset(HeightScale(3));
        make.left.right.equalTo(title2);
    }];
    
    UILabel *title3 = [UILabel creatLabelWithFont:17 andbgcolor:nil andtextColor:SF_COLOR(51, 51, 51) andAligment:0];
    title3.text = @"三、关于作弊处理";
    [self.view addSubview:title3];
    [title3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.bottom).offset(HeightScale(24));
        make.left.equalTo(WidthScale(12));
        make.right.equalTo(-WidthScale(12));
    }];
    
    UILabel *label3 = [UILabel creatLabelWithFont:15 andbgcolor:nil andtextColor:SF_COLOR(102, 102, 102) andAligment:0];
    label3.text = @"   一旦发现刷机等作弊方式，账号会被系统立即禁用。如果正常用户被“误禁”，可联系客服进行解决，一旦采信，我们将重新恢复禁用的账号，之前所有收入不会受到影响。";
    [self.view addSubview:label3];
    
    [label3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title3.bottom).offset(HeightScale(3));
        make.left.right.equalTo(title1);
    }];
    
    label.numberOfLines = 0;
    label2.numberOfLines = 0;
    label3.numberOfLines = 0;
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
