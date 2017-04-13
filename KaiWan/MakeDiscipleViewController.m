//
//  MakeDiscipleViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/7.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "MakeDiscipleViewController.h"
#import "ShowListViewController.h"
#import "LianJieViewController.h"
@interface MakeDiscipleViewController ()
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *todayDisciplelabel;
@property (nonatomic,strong) UILabel *todayEffectiveDis;
@property (nonatomic,strong) UILabel *totalDIsciplelabel;
@property (nonatomic,strong) UILabel *totalMoney;

@end

@implementation MakeDiscipleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"收徒";
    [self setNavigationBar];
    [self creatUI];
    [self request];
}
- (void)request {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Share.html?uid=%@",HostUrl,del.uid] parameters:nil sucsess:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        NSDictionary *dica = dic[@"data"];
        self.todayDisciplelabel.text = [NSString stringWithFormat:@"今日收徒：%@",[NSString creatWithId:dica[@"tsons"]]];
        self.todayEffectiveDis.text = [NSString stringWithFormat:@"今日有效收徒：%@",[NSString creatWithId:dica[@"invite_day_count_e"]]];
        self.totalDIsciplelabel.text = [NSString stringWithFormat:@"累计收徒：%@",[NSString creatWithId:dica[@"invite_all_count"]]];
        self.totalMoney.text = [NSString stringWithFormat:@"累计奖励：%@",[NSString creatWithId:dica[@"invite_money_sum"]]];
        self.moneyLabel.text = [NSString creatWithId:dica[@"invite_money_day_sum"]];
        
    } fail:^(NSError *error) {
        
    } andViewController:self];
}
- (void)creatUI {
    UIView *headview = [[UIView alloc]init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[ (__bridge id)SF_COLOR(28, 108, 229).CGColor, (__bridge id)SF_COLOR(64, 140, 254).CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = [UIView setRectWithX:0 andY:0 andWidth:375 andHeight:165];
    [headview.layer addSublayer:gradientLayer];
    [self.view addSubview:headview];
    
    [headview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview.bottom);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo([UIView setHeight:165]);
    }];
    
    self.moneyLabel = [UILabel creatLabelWithFont:48 andbgcolor:nil andtextColor:[UIColor whiteColor] andAligment:NSTextAlignmentCenter];
    self.moneyLabel.text = @"21.00";
    [headview addSubview:self.moneyLabel];
    
    UILabel *label = [UILabel creatLabelWithFont:12 andbgcolor:nil andtextColor:SF_COLOR(215, 231, 255) andAligment:1];
    [headview addSubview:label];
    label.text = @"今日徒弟收益(元)";
    
    self.todayDisciplelabel = [UILabel creatLabelWithFont:14 andbgcolor:nil andtextColor:SF_COLOR(215, 231, 255) andAligment:0];
    [headview addSubview:self.todayDisciplelabel];
    
    self.todayEffectiveDis = [UILabel creatLabelWithFont:14 andbgcolor:nil andtextColor:SF_COLOR(215, 231, 255) andAligment:0];
    [headview addSubview:self.todayEffectiveDis];
    
    self.totalDIsciplelabel = [UILabel creatLabelWithFont:14 andbgcolor:nil andtextColor:SF_COLOR(215, 231, 255) andAligment:0];
    [headview addSubview:self.totalDIsciplelabel];
    
    self.totalMoney = [UILabel creatLabelWithFont:14 andbgcolor:nil andtextColor:SF_COLOR(215, 231, 255) andAligment:0];
    [headview addSubview:self.totalMoney];
    
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([UIView setHeight:0]);
        make.centerX.equalTo(headview);
    }];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLabel.bottom).offset([UIView setHeight:5]);
        make.centerX.equalTo(headview);
    }];
    [self.todayDisciplelabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.bottom).offset([UIView setHeight:28]);
        make.left.equalTo([UIView setWidth:12]);
    }];
    [self.todayEffectiveDis makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.todayDisciplelabel.bottom).offset([UIView setHeight:6]);
        make.left.equalTo(self.todayDisciplelabel);
    }];
    [self.totalDIsciplelabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.todayDisciplelabel.top);
        make.left.equalTo(headview.centerX).offset([UIView setWidth:10]);
    }];
    [self.totalMoney makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.todayEffectiveDis.top);
        make.left.equalTo(self.totalDIsciplelabel);
    }];
    
    UIView *wihteView = [[UIView alloc]init];
    wihteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:wihteView];
    [wihteView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headview.bottom).offset([UIView setHeight:7]);
        make.left.right.equalTo(self.view);
        make.height.equalTo([UIView setHeight:35+63*3]);
    }];
    
    UILabel *titlelabel = [UILabel creatLabelWithFont:14 andbgcolor:nil andtextColor:SF_COLOR(233, 96, 96) andAligment:NSTextAlignmentCenter];
    [wihteView addSubview:titlelabel];
    
    [titlelabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(wihteView);
        make.height.equalTo([UIView setHeight:35]);
    }];
    titlelabel.text = @"教你如何快速收徒，日进斗金？";
    
   
    NSArray *title = @[@"晒单收徒",@"扫码收徒",@"链接收徒"];
    NSArray *detail = @[@"适合于社交收徒",@"适用于面对面收徒",@"复制黏贴传播更快捷"];
    for (int i = 0; i < 3; i ++) {
        UILabel *linelabel = [UILabel creatLabelWithFont:0 andbgcolor:SF_COLOR(229, 229, 229) andtextColor:nil andAligment:0];
        [wihteView addSubview:linelabel];
        [linelabel makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(titlelabel).offset([UIView setHeight:i*63]);
            make.centerX.equalTo(titlelabel);
            make.width.equalTo([UIView setWidth:351]);
            make.height.equalTo(1);
        }];
        UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:title[i]]];
        [wihteView addSubview:image1];
        
        UILabel *shaiLabel = [UILabel creatLabelWithFont:16 andbgcolor:nil andtextColor:SF_COLOR(51, 51, 51) andAligment:0];
        shaiLabel.text = title[i];
        [wihteView addSubview:shaiLabel];
        
        UILabel *mianLabel = [UILabel creatLabelWithFont:12 andbgcolor:nil andtextColor:SF_COLOR(193, 193, 193) andAligment:0];
        mianLabel.text = detail[i];
        [wihteView addSubview:mianLabel];
        
        UIImageView *image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"收徒-箭头"]];
        [wihteView addSubview:image2];
        
        [image1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titlelabel.bottom).offset([UIView setHeight:10+i*63]);
            make.left.equalTo([UIView setWidth:12]);
            make.height.width.equalTo([UIView setHeight:43]);
        }];
        
        [shaiLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image1.right).offset([UIView setWidth:8]);
            make.bottom.equalTo(image1.centerY).offset(-[UIView setHeight:4]);
            
        }];
        [mianLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shaiLabel);
            make.top.equalTo(image1.centerY).offset([UIView setHeight:4]);
        }];
        
        [image2 makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-[UIView setWidth:6.5]);
            make.centerY.equalTo(image1.centerY);
            make.width.and.height.equalTo([UIView setHeight:20]);
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(showBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 280+i;
        [wihteView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(linelabel.bottom);
            make.left.right.equalTo(0);
            make.height.equalTo([UIView setHeight:63]);
        }];
    }
    
        UIImageView *image3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"收徒规则"]];
    [self.view addSubview:image3];
    
    UILabel *glabel = [UILabel creatLabelWithFont:14 andbgcolor:nil andtextColor:SF_COLOR(92, 148, 233) andAligment:0];
    glabel.text = @"收徒规则";
    [self.view addSubview:glabel];
    
    UILabel *glabel1 = [UILabel creatLabelWithFont:12 andbgcolor:nil andtextColor:SF_COLOR(145, 145, 145) andAligment:0];
    NSMutableAttributedString *mstr1 = [[NSMutableAttributedString alloc]initWithString:@"1.徒弟完成限时任务，你可获得总计5元收徒奖励"];
    [mstr1 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(231, 69, 69) range:NSMakeRange(6, 4)];
    [mstr1 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(231, 69, 69) range:NSMakeRange(17, 2)];
    glabel1.attributedText = mstr1;
    [self.view addSubview:glabel1];
    
    UILabel *glabel2 = [UILabel creatLabelWithFont:12 andbgcolor:nil andtextColor:SF_COLOR(145, 145, 145) andAligment:0];
    NSMutableAttributedString *mstr2 = [[NSMutableAttributedString alloc]initWithString:@"2.徒弟完成第一个限时任务，你可获得2元收徒奖励，之后每完成一个限时任务，你均可获得1元任务奖励，五元封顶"];
    glabel2.lineBreakMode = NSLineBreakByWordWrapping;
    glabel2.numberOfLines = 0;
    [mstr2 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(231, 69, 69) range:NSMakeRange(18, 2)];
    [mstr2 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(231, 69, 69) range:NSMakeRange(41, 2)];
    [mstr2 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(231, 69, 69) range:NSMakeRange(48, 4)];

    glabel2.attributedText = mstr2;
    [self.view addSubview:glabel2];
    
  
    [image3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wihteView.bottom).offset([UIView setHeight:15]);
        make.left.equalTo([UIView setWidth:18]);
        make.width.height.equalTo([UIView setWidth:14.5]);
        
    }];
    [glabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image3);
        make.left.equalTo(image3.right).offset([UIView setWidth:5]);
    }];
    
    [glabel1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image3.bottom).offset([UIView setHeight:12]);
        make.left.equalTo(image3);
    }];
    [glabel2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(glabel1);
        make.top.equalTo(glabel1.bottom).offset([UIView setHeight:8]);
        make.width.equalTo([UIView setWidth:375-18*2]);
    }];
    
//    UIButton *btn = [UIButton creatButtonWithTitle:@"立即收徒" andBgColor:SF_COLOR(28, 108, 229) andTextColor:[UIColor whiteColor] andtitleFont:23];
//    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    btn.layer.cornerRadius = 8;
//    btn.clipsToBounds = YES;
//    [btn makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(glabel2.bottom).offset([UIView setHeight:46]);
//        make.centerX.equalTo(self.view);
//        make.width.equalTo([UIView setWidth:301]);
//        make.height.equalTo([UIView setHeight:44]);
//    }];
}
- (void)showBtnClick:(UIButton *)btn {
    switch (btn.tag-280) {
        case 0:
            [self.navigationController pushViewController:[[ShowListViewController alloc]init] animated:YES];
            break;
        case 1:
            
            break;
        case 2:
            [self.navigationController pushViewController:[[LianJieViewController alloc]init] animated:YES];

            break;
            
        default:
            break;
    }
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
