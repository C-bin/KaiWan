//
//  WeChatViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/17.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "WeChatViewController.h"

@interface WeChatViewController ()
@property (nonatomic,strong) UITextField *zhangHaoTf;

@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@end

@implementation WeChatViewController
{
    int money;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    money = 10;
    self.titlestring = @"微信提现";
    [self setNavigationBar];
    [self creatUI];
    
}
- (void)creatUI {
    UIView *aview = [[UIView alloc]init];
    aview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:aview];
    
    [aview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview.bottom).offset(HeightScale(12));
        make.right.left.equalTo(0);
        make.height.equalTo(HeightScale(48));
    }];
    
    UILabel *plabel = [[UILabel alloc]init];
    plabel.backgroundColor = SF_COLOR(28, 108, 229);
    [aview addSubview:plabel];
    [plabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(WidthScale(12));
        make.centerY.equalTo(aview.top).offset(HeightScale(22));
        make.height.equalTo(HeightScale(16));
        make.width.equalTo(WidthScale(4));
    }];
    
    UILabel *titleLabel = [UILabel creatLabelWithFont:15 andbgcolor:nil andtextColor:SF_COLOR(51, 51, 51) andAligment:0];
    titleLabel.text = @"姓名  ";
    [aview addSubview:titleLabel];
    
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(plabel.right).offset(WidthScale(6));
        make.top.equalTo(0);
        make.height.equalTo(HeightScale(48));
        
    }];
    
    UILabel *linelabel = [[UILabel alloc]init];
    linelabel.backgroundColor = SF_COLOR(232, 232, 232);
    [aview addSubview:linelabel];
    
    [linelabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.bottom);
        make.left.equalTo(self.view).offset(WidthScale(12));
        make.right.equalTo(self.view).offset(-WidthScale(12));
        make.height.equalTo(1);
    }];
    self.zhangHaoTf = [[UITextField alloc]init];
    NSString *str = @"请输入微信绑定的银行卡姓名";
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:str];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(220, 220, 220) range:NSMakeRange(0, str.length)];
    [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, str.length)];
    self.zhangHaoTf.attributedPlaceholder = mstr;
    self.zhangHaoTf.font = [UIFont systemFontOfSize:15];
    [aview addSubview:self.zhangHaoTf];
    
    [self.zhangHaoTf makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(titleLabel);
        make.left.equalTo(titleLabel.right);
        make.right.equalTo(0);
    }];
    
    
    UIView *bview = [[UIView alloc]init];
    bview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bview];
    
    [bview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aview.bottom).equalTo(HeightScale(12));
        make.right.left.equalTo(0);
        make.height.equalTo(HeightScale(219));
        
    }];
    
    UILabel *plabel1 = [[UILabel alloc]init];
    plabel1.backgroundColor = SF_COLOR(28, 108, 229);
    [bview addSubview:plabel1];
    [plabel1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(WidthScale(12));
        make.centerY.equalTo(aview.top).offset(HeightScale(22));
        make.height.equalTo(HeightScale(16));
        make.width.equalTo(WidthScale(4));
    }];
    
    self.moneyLabel = [UILabel creatLabelWithFont:16 andbgcolor:nil andtextColor:SF_COLOR(51, 51, 51) andAligment:0];
    self.moneyLabel.text = @"请选择提现金额";
    [bview addSubview:self.moneyLabel];
    
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(plabel1.right).offset(-WidthScale(6));
        make.height.equalTo(HeightScale(46));
    }];
    
    UILabel *linelabel1 = [UILabel creatLabelWithFont:1 andbgcolor:SF_COLOR(232, 232, 232) andtextColor:nil andAligment:0];
    [bview addSubview:linelabel1];
    [linelabel1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLabel.bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(1);
    }];
    UIView *firstview = nil;
    
    NSArray *titleArr = @[@"10元",@"20元",@"50元",@"100元"];
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:SF_COLOR(28, 108, 229) forState:UIControlStateSelected];
        [btn setTitleColor:SF_COLOR(130, 130, 130) forState:UIControlStateNormal];
        btn.layer.cornerRadius = 4;
        btn.clipsToBounds = YES;
        btn.layer.borderColor = SF_COLOR(220, 220, 220).CGColor;
        btn.layer.borderWidth = 1;
        [bview addSubview:btn];
        btn.tag = 700+i;
        
        if (i==0) {
            btn.selected = YES;
            btn.layer.borderColor = SF_COLOR(28,108,229).CGColor;
            
            firstview = btn;
        }
        switch (i) {
            case 0:{
                [btn makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(WidthScale(35));
                    make.top.equalTo(linelabel1).offset(HeightScale(17));
                    make.width.equalTo(WidthScale(120));
                    make.height.equalTo(HeightScale(45));
                }];}
                break;
            case 1:
            {
                [btn makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(firstview.right).offset(WidthScale(65));
                    make.top.equalTo(linelabel1).offset(HeightScale(17));
                    make.width.equalTo(WidthScale(120));
                    make.height.equalTo(HeightScale(45));
                }];}
                
                break;
            case 2:
            {
                [btn makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(firstview);
                    make.top.equalTo(firstview.bottom).offset(HeightScale(26));
                    make.width.equalTo(WidthScale(120));
                    make.height.equalTo(HeightScale(45));
                }];}
                break;
            case 3:
            {
                [btn makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(firstview.right).offset(WidthScale(65));
                    make.top.equalTo(firstview.bottom).offset(HeightScale(26));
                    make.width.equalTo(WidthScale(120));
                    make.height.equalTo(HeightScale(45));
                }];}
                break;
                
            default:
                break;
        }
        
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    self.subTitleLabel = [UILabel creatLabelWithFont:13 andbgcolor:nil andtextColor:SF_COLOR(206, 206, 206) andAligment:0];
    NSString *subtit = @"需收取手续费1元，到账9元";
    NSMutableAttributedString *subMtit = [[NSMutableAttributedString alloc]initWithString:subtit];
    [subMtit addAttribute:NSForegroundColorAttributeName value:SF_COLOR(219, 3, 3) range:NSMakeRange(6, 1)];
    [subMtit addAttribute:NSForegroundColorAttributeName value:SF_COLOR(219, 3, 3) range:NSMakeRange(11, 2)];
    self.subTitleLabel.attributedText = subMtit;
    [bview addSubview:self.subTitleLabel];
    [self.subTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstview.bottom).offset(WidthScale(89));
        make.centerX.equalTo(0);
    }];
    
    UILabel *label1 = [UILabel creatLabelWithFont:14 andbgcolor:nil andtextColor:SF_COLOR(153, 153, 153) andAligment:0];
    label1.text = @"＊提现说明";
    [self.view addSubview:label1];
    [label1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bview.bottom).offset(HeightScale(14));
        make.left.equalTo(WidthScale(12));
    }];
    UILabel *label2 = [UILabel creatLabelWithFont:13 andbgcolor:nil andtextColor:SF_COLOR(153, 153, 153) andAligment:0];
    NSString *str11 = @"1.请填写微信绑定银行卡的真实姓名，确保打款验证通过；\n2.提现将于次日22:00前到账（周末节假日不打款）请耐心等待；\n3.如提现失败，提现金额将于48小时内退回。";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str11];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:2];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str11 length])];
    label2.attributedText = attrStr;
    label2.numberOfLines = 0;
    [label2 sizeToFit];
    [self.view addSubview:label2];
    
    [label2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.bottom).offset(HeightScale(6));
        make.left.equalTo(WidthScale(22));
        make.right.equalTo(-WidthScale(22));
        
    }];
    UIButton *sharebtn = [UIButton creatButtonWithTitle:@"马上提现" andBgColor:SF_COLOR(28, 108, 229) andTextColor:SF_COLOR(255, 255, 255) andtitleFont:23];
    [sharebtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sharebtn];
    sharebtn.layer.cornerRadius = 10;
    sharebtn.clipsToBounds = YES;
    [sharebtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-HeightScale(49));
        make.width.equalTo([UIView setWidth:320]);
        make.centerX.equalTo(0);
        make.height.equalTo([UIView setHeight:44]);
    }];
    
}
- (void)btnclick:(UIButton *)btn {
    NSArray *titarr = @[@"9",@"19",@"49",@"99"];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [self.view viewWithTag:700+i];
        button.selected = NO;
        button.layer.borderColor = SF_COLOR(220, 220, 220).CGColor;
    }
    btn.selected = YES;
    btn.layer.borderColor = SF_COLOR(28,108,229).CGColor;
    int a[4] = {10,20,50,100};
    money = a[(int)btn.tag-700];
    NSLog(@"%d",money);
    NSString *subtit = [NSString stringWithFormat:@"需收取手续费1元，到账%@元",titarr[btn.tag-700]];
    NSMutableAttributedString *subMtit = [[NSMutableAttributedString alloc]initWithString:subtit];
    [subMtit addAttribute:NSForegroundColorAttributeName value:SF_COLOR(219, 3, 3) range:NSMakeRange(6, 1)];
    [subMtit addAttribute:NSForegroundColorAttributeName value:SF_COLOR(219, 3, 3) range:NSMakeRange(11, 2)];
    self.subTitleLabel.attributedText = subMtit;
    
    
}
- (void)shareClick:(UIButton *)btn {

    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *dic = @{
                          @"tid":@"2",
                          @"uid":del.uid,
                          @"name":self.zhangHaoTf.text,
                          @"money":[NSString stringWithFormat:@"%d",money]
                          };
    [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Deposit/submit.html",HostUrl] parameters:dic sucsess:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        NSNumber *num = dic[@"code"];
        if (num.integerValue==1) {
            MBProgressHUD *mbpr = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            mbpr.mode = MBProgressHUDModeText;
            mbpr.label.text = dic[@"message"];
            [mbpr hideAnimated:YES afterDelay:2];

        }
    } fail:^(NSError *error) {
        
    } andViewController:self];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.zhangHaoTf resignFirstResponder];
    
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
