//
//  WithDrawMethodViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/14.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "WithDrawMethodViewController.h"

@interface WithDrawMethodViewController ()

@end

@implementation WithDrawMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"提现方式";
    [self setNavigationBar];
    [self creatUI];
}
- (void)creatUI {
    UIView *bview = [[UIView alloc]init];
    bview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bview];
    
    [bview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview.bottom).offset(HeightScale(12));
        make.left.right.equalTo(0);
        make.height.equalTo(HeightScale(164));
    }];
    UILabel *linelabel = [[UILabel alloc]init];
    linelabel.backgroundColor = SF_COLOR(229, 229, 229);
    [bview addSubview:linelabel];
    [linelabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.height.equalTo(1);
    }];
    UILabel *linelabel1 = [[UILabel alloc]init];
    linelabel1.backgroundColor = SF_COLOR(229, 229, 229);
    [bview addSubview:linelabel1];
    [linelabel1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(1);
    }];
    
    UILabel *plabel = [[UILabel alloc]init];
    plabel.backgroundColor = SF_COLOR(28, 108, 229);
    [bview addSubview:plabel];
    [plabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(WidthScale(12));
        make.centerY.equalTo(bview.top).offset(HeightScale(22));
        make.height.equalTo(HeightScale(16));
        make.width.equalTo(WidthScale(4));
    }];
    
    UILabel *titleLabel = [UILabel creatLabelWithFont:15 andbgcolor:nil andtextColor:SF_COLOR(51, 51, 51) andAligment:0];
    titleLabel.text = @"请选择提现方式";
    [bview addSubview:titleLabel];
    
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(plabel.right).offset(WidthScale(6));
        make.top.equalTo(0);
        make.height.equalTo(HeightScale(44));
        
    }];
    
    UILabel *linelabel2 = [[UILabel alloc]init];
    linelabel2.backgroundColor = SF_COLOR(229, 229, 229);
    [bview addSubview:linelabel2];
    [linelabel2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(plabel.left);
        make.right.equalTo(0);
        make.height.equalTo(1);
        make.top.equalTo(titleLabel.bottom);
    }];
    
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"微信支付"]];
    [bview addSubview:image1];
    
    [image1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(plabel.left);
        make.centerY.equalTo(linelabel2.bottom).offset(HeightScale(30));
        make.width.height.equalTo(HeightScale(41));
    }];
    
    UILabel*wlabel = [UILabel creatLabelWithFont:15 andbgcolor:nil andtextColor:SF_COLOR(0, 0, 0) andAligment:0];
    wlabel.text = @"微信";
    [bview addSubview:wlabel];
    
    UILabel *wtlabel = [UILabel creatLabelWithFont:12 andbgcolor:nil andtextColor:SF_COLOR(153, 153, 153) andAligment:0];
    NSString *str = @"仅支持十元以上金额";
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:str];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(240, 35, 78) range:NSMakeRange(3, 2)];
    [bview addSubview:wtlabel];
    
    [wlabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(image1.centerY).offset(-HeightScale(3));
        make.left.equalTo(image1.right).offset(WidthScale(12));
        
    }];
    [wtlabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image1.centerY).offset(HeightScale(3));
        make.left.equalTo(wlabel);
    }];
    wtlabel.attributedText = mstr;
    UIImageView *image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"提现方式-箭头"]];;
    [bview addSubview:image2];
    [image2 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bview.right).offset(-WidthScale(3));
        make.centerY.equalTo(image1);
        make.width.height.equalTo(HeightScale(25));
    }];
    
    
    UILabel *linelabel3 = [[UILabel alloc]init];
    linelabel3.backgroundColor = SF_COLOR(229, 229, 229);
    [bview addSubview:linelabel3];
    [linelabel3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(linelabel2.left);
        make.right.equalTo(0);
        make.height.equalTo(1);
        make.top.equalTo(linelabel2.bottom).offset(HeightScale(60));
    }];
    

    
    UIImageView *image3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"支付宝支付"]];
    [bview addSubview:image3];
    
    [image3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(plabel.left);
        make.centerY.equalTo(linelabel3.bottom).offset(HeightScale(30));
        make.width.height.equalTo(HeightScale(41));
    }];
    
    UILabel*zlabel = [UILabel creatLabelWithFont:15 andbgcolor:nil andtextColor:SF_COLOR(0, 0, 0) andAligment:0];
    zlabel.text = @"支付宝";
    [bview addSubview:zlabel];
    
    UILabel *ztlabel = [UILabel creatLabelWithFont:12 andbgcolor:nil andtextColor:SF_COLOR(153, 153, 153) andAligment:0];
    NSString *str1 = @"仅支持二十元以上金额";
    NSMutableAttributedString *mstr1 = [[NSMutableAttributedString alloc]initWithString:str1];
    [mstr1 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(240, 35, 78) range:NSMakeRange(3, 3)];
    ztlabel.attributedText = mstr1;
    [bview addSubview:ztlabel];
    
    [zlabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(image3.centerY).offset(-HeightScale(3));
        make.left.equalTo(image3.right).offset(WidthScale(12));
        
    }];
    [ztlabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image3.centerY).offset(HeightScale(3));
        make.left.equalTo(zlabel);
    }];
    
    UIImageView *image4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"提现方式-箭头"]];;
    [bview addSubview:image4];
    [image4 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bview.right).offset(-WidthScale(3));
        make.centerY.equalTo(image3);
        make.width.height.equalTo(HeightScale(25));
    }];
    

    for (int i = 0; i<2; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn addTarget:self action:@selector(jumpToWithDrawSender:) forControlEvents:UIControlEventTouchUpInside];
        [bview addSubview:btn];
//        btn.backgroundColor = [UIColor redColor];
        btn.tag = 510+i;
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = [UIView setRectWithX:0 andY:44+60*i andWidth:375 andHeight:60];

    }
}
- (void)jumpToWithDrawSender:(UIButton *)btn {
    if (btn.tag==510) {
        
    }else {
        
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
