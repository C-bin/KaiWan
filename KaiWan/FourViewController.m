//
//  FourViewController.m
//  KaiWan
//
//  Created by chenguang on 17/3/2.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "FourViewController.h"
#import "MakeViewController.h"
#import "SonViewController.h"
#import "WIthdrawViewController.h"
#import "OurViewController.h"
#import "SetupViewController.h"
#import "HezuoViewController.h"
#import "QuestionViewController.h"
@interface FourViewController ()
@property (nonatomic, strong)UIImageView *headIcon;
@property (nonatomic, strong)UILabel *namelabel;
@property (nonatomic, strong)UILabel *idLabel;
@property (nonatomic,strong) NSDictionary *dic;

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SF_COLOR(235, 235, 235);
    [self creatUI];
    
}

- (void)reloadData {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [RequestData GetDataWithURL:[NSString stringWithFormat:@
"%@User.html?uid=%@",HostUrl,del.uid] parameters:nil sucsess:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        NSLog(@"%@",dic);
        
        NSDictionary *dica = dic[@"data"];
        NSDictionary *dicb = dica[@"user_info"];
        [self.headIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,dicb[@"avatar"]]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
        self.dic = [[NSDictionary alloc]initWithDictionary:dicb];
        self.idLabel.text = [NSString stringWithFormat:@"ID:%@",[NSString creatWithId:dicb[@"id"]]];
        self.namelabel.text = [NSString creatWithId:dicb[@"nickname"]];

        
        UILabel *label = (UILabel *)[self.view viewWithTag:210];
        NSString *str = [NSString creatWithId:dica[@"task_sum"]];
        NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",dica[@"task_sum"]]];
        [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, str.length)];
        [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(str.length, 1)];
        label.attributedText = mstr;

        
        UILabel *label1 = (UILabel *)[self.view viewWithTag:211];
        NSString *str1 = [NSString creatWithId:dica[@"redeem_sum"]];
        NSMutableAttributedString *mstr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",dica[@"redeem_sum"]]];
        [mstr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, str1.length)];
        [mstr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(str1.length, 1)];
        label1.attributedText = mstr1;
        
        
        UILabel *label2 = (UILabel *)[self.view viewWithTag:212];
        NSString *str2 = [NSString creatWithId:dica[@"invite_sum"]];
        NSMutableAttributedString *mstr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",dica[@"invite_sum"]]];
        [mstr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, str2.length)];
        [mstr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(str2.length, 1)];
        label2.attributedText = mstr2;
        
        
        
    } fail:^(NSError *error) {
//        NSLog(@"%@",error);
    } andViewController:self];
    
    
}
- (void)creatUI {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:20];
    label.text = @"个人中心";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64+[UIView setHeight:97])];
    bgview.backgroundColor = SF_COLOR(28, 108, 229);
    [bgview addSubview:label];
    [self.view addSubview:bgview];
    self.headIcon = [[UIImageView alloc]init];
    _headIcon.layer.cornerRadius = [UIView setHeight:60/2];
    _headIcon.clipsToBounds = YES;
    self.headIcon.backgroundColor = [UIColor whiteColor];
    [bgview addSubview:self.headIcon];
    
    [self.headIcon makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(label.bottom).offset([UIView setHeight:8]);
        make.left.equalTo([UIView setWidth:12]);
        make.width.and.height.equalTo([UIView setHeight:60]);
        
    }];
    
    self.headIcon.userInteractionEnabled = YES;
    
    self.namelabel = [[UILabel alloc]init];
    self.namelabel.font = [UIFont systemFontOfSize:13];
    self.namelabel.text = @"汽油此女";
    self.namelabel.textColor = [UIColor whiteColor];
    [bgview addSubview:self.namelabel];
    
    [self.namelabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.bottom).offset([UIView setHeight:22]);
        make.left.equalTo(self.headIcon.right).offset([UIView setWidth:10]);
        
    }];
    
    
    self.idLabel = [[UILabel alloc]init];
    self.idLabel.font = [UIFont systemFontOfSize:13];
    self.idLabel.text = @"123123";
    self.idLabel.textColor = [UIColor whiteColor];
    
    [bgview addSubview: self.idLabel];
    [self.idLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.namelabel.bottom).offset([UIView setHeight:10]);
        make.left.equalTo(self.namelabel.left);

    }];
    
    UILabel *setLabel = [[UILabel alloc]init];
    setLabel.text = @"个人资料";
    setLabel.textColor = [UIColor whiteColor];
    setLabel.font = [UIFont systemFontOfSize:12];
    [bgview addSubview:setLabel];
    setLabel.userInteractionEnabled = YES;
    bgview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setBtnClick)];
    [setLabel addGestureRecognizer:tap];
    [self.headIcon addGestureRecognizer:tap];
   
    UIButton *setBtn = [[UIButton alloc]init];
    [setBtn setBackgroundImage:[UIImage imageNamed:@"个人资料-箭头"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:setBtn];
    
    
    [setBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgview.right).offset(-[UIView setWidth:12]);
        make.width.and.height.equalTo([UIView setWidth:20]);
        make.centerY.equalTo(self.headIcon);
        
    }];
    [setLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headIcon);
        make.right.equalTo(setBtn.left);
        
    }];
    NSArray *title = @[@"任务收入",@"提现余额",@"收徒金额"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH/3.f*i, CGRectGetMaxY(bgview.frame), SWIDTH/3.f, [UIView setHeight:74])];
        button.tag = 200+i;
        [button addTarget:self action:@selector(moneyClick:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:button];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH/3.f-1, [UIView setHeight:16], 1, [UIView setHeight:40])];
        label.backgroundColor = SF_COLOR(222, 222, 222);
        
        UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIView setHeight:6], SWIDTH/3.f, [UIView setHeight:40])];
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        [button addSubview:moneyLabel];
        
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIView setHeight:46], SWIDTH/3.f, 14)];
        titlelabel.font = [UIFont systemFontOfSize:14];
        titlelabel.textAlignment = NSTextAlignmentCenter;
        titlelabel.textColor = SF_COLOR(51, 51, 51);
        titlelabel.text = title[i];
        [button addSubview:titlelabel];
        
        moneyLabel.tag = 210+i;
        if (i==0) {
            [button addSubview:label];
            moneyLabel.textColor = SF_COLOR(255, 107, 55);
        }else if(i==1) {
            [button addSubview:label];
            moneyLabel.textColor = SF_COLOR(255, 161, 49);

        }else {
            moneyLabel.textColor = SF_COLOR(219, 3, 3);

        }
    }
    UILabel *bglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgview.frame)+[UIView setHeight:74], SWIDTH, [UIView setHeight:10])];
    bglabel.backgroundColor = SF_COLOR(235, 235, 235);
    
    
    [self.view addSubview:bglabel];
    UILabel *llabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:0.5]];
    llabel.backgroundColor = SF_COLOR(229, 229, 229);
    [bglabel addSubview:llabel];
    
    
    UILabel *llabel1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:9.5 andWidth:375 andHeight:0.5]];
    llabel1.backgroundColor = SF_COLOR(229, 229, 229);
    [bglabel addSubview:llabel1];
    
    
    NSArray *imageArr = @[@"邀请好友",@"疑难解答",@"商务合作",@"关于我们"];
    
    for (int i = 0; i < 4; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bglabel.frame)+[UIView setHeight:42]*i, SWIDTH, [UIView setHeight:42])];
        view.userInteractionEnabled = YES;
        view.tag = 220+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [view addGestureRecognizer:tap];
        [self.view addSubview:view];
        
        UIImageView *iconimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageArr[i]]];
        [view addSubview:iconimage];
        
        [iconimage makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo([UIView setWidth:12]);
            make.top.equalTo([UIView setHeight:8]);
            make.width.height.equalTo([UIView setHeight:26]);
        }];
        
        
        UILabel *label = [[UILabel alloc]init];
        
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = SF_COLOR(102, 102, 102);
        label.text = imageArr[i];
        
        [view addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconimage.right).offset([UIView setWidth:8]);
            make.top.equalTo(0);
            make.height.equalTo(view);
            
        }];
        
        UILabel *linelabel = [[UILabel alloc]init];
        [view addSubview:linelabel];
        linelabel.backgroundColor = SF_COLOR(229, 229, 229);
        
        [linelabel makeConstraints:^(MASConstraintMaker *make) {
            if (i!=3) {
                make.left.equalTo(label);

            }else {
                make.left.equalTo(view);

            }
            make.right.equalTo(view.right);
            make.height.equalTo(0.5);
            make.top.equalTo(view.bottom).offset(-0.5);
        }];
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"个人中心-箭头"]];
        [view addSubview:image];
        
        [image makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-[UIView setWidth:12]);
            make.centerY.equalTo(view);
         
            make.width.height.equalTo([UIView setWidth:20]);
        }];
        
        view.backgroundColor = [UIColor whiteColor];
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self reloadData];
}
- (void)tapClick :(UITapGestureRecognizer *)tap {
    
    NSLog(@"%ld",tap.view.tag);
    switch (tap.view.tag) {
        case 220:
        {
            NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"3"}];
            [[NSNotificationCenter defaultCenter] postNotification:notice];
        }
            break;
        case 221:
            [self.navigationController pushViewController:[[QuestionViewController alloc]init] animated:YES];

            break;
        case 222:
            [self.navigationController pushViewController:[[HezuoViewController alloc]init] animated:YES];
            break;
        case 223:
            
            [self.navigationController pushViewController:[[OurViewController alloc]init] animated:YES];
            break;
        case 224:
            
            break;
            
        default:
            break;
    }
}
#pragma mark 任务收入
- (void)moneyClick :(UIButton *)btn {
    switch (btn.tag) {
        case 200:
            [self.navigationController pushViewController:[[MakeViewController alloc]init] animated:YES];

            break;
        case 201:
            [self.navigationController pushViewController:[[WIthdrawViewController alloc]init] animated:YES];

            break;
        case 202:
            [self.navigationController pushViewController:[[SonViewController alloc]init] animated:YES];

            break;
            
        default:
            break;
    }
}
#pragma mark 设置

- (void)setBtnClick {
    SetupViewController *set = [[SetupViewController alloc]init];
    set.dataDic = self.dic;
    [self.navigationController pushViewController:set animated:YES];
    
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
