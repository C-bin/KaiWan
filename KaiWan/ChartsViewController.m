//
//  ChartsViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/7.
//  Copyright © 2017年 chenguang. All rights reserved.
//


#import "ChartsViewController.h"
#import "ChartsTableViewCell.h"

@interface ChartsViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    AppDelegate *_delegate;
}
@property (nonatomic,strong) UIImageView *headicon;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *idLabel;
@property (nonatomic,strong) UILabel *discipleNumLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UITableView *table;
@property (nonatomic, strong) NSArray * dayRankArr;
@property (nonatomic, strong) NSArray * allRankArr;
@property (nonatomic, assign) BOOL isDayRank;


@end

@implementation ChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"排行榜";
    
    _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [self setNavigationBar];
    
    [self creatUI];
    
    [self requestRankData];
    
    _isDayRank = YES;
    
}

- (void)creatUI {
    //21
    UIView *headview = [[UIView alloc]init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[ (__bridge id)SF_COLOR(28, 108, 229).CGColor, (__bridge id)SF_COLOR(60, 136, 251).CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = [UIView setRectWithX:0 andY:0 andWidth:375 andHeight:106];
    [headview.layer addSublayer:gradientLayer];
    [self.view addSubview:headview];
    
    [headview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview.bottom);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo([UIView setHeight:106]);
    }];
    
    self.headicon = [[UIImageView alloc]init];
    self.headicon.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headicon.layer.cornerRadius = [UIView setWidth:30];
    self.headicon.clipsToBounds = YES;
    self.headicon.layer.borderWidth = 0.5;
    [self.headicon sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"user_info"][@"headimgurl"]]];
    [headview addSubview:self.headicon];
    
    
    self.numLabel = [[UILabel alloc]init];
    self.numLabel.layer.cornerRadius = [UIView setHeight:7.5];
    self.numLabel.clipsToBounds = YES;
    self.numLabel.backgroundColor = SF_COLOR(232, 132, 132);
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.font = [UIFont systemFontOfSize:10];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
//    self.numLabel.text = self.dataDic[@"user_info"][@"place"];
    self.numLabel.hidden = YES;
    [headview addSubview:self.numLabel];
    
    
    self.idLabel = [UILabel creatLabelWithFont:18 andbgcolor:nil andtextColor:[UIColor whiteColor] andAligment:0];
    self.idLabel.text = self.dataDic[@"user_info"][@"nickname"];
    [headview addSubview:self.idLabel];
    
    self.discipleNumLabel = [UILabel creatLabelWithFont:12 andbgcolor:nil andtextColor:SF_COLOR(215, 231, 255) andAligment:0];
    
    [headview addSubview:self.discipleNumLabel];
    
    
    self.moneyLabel = [UILabel creatLabelWithFont:12 andbgcolor:nil andtextColor:SF_COLOR(215, 231, 255) andAligment:0];
    [headview addSubview:self.moneyLabel];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"我要进榜" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor  = [UIColor whiteColor].CGColor;
    btn.layer.borderWidth = 1;
    btn.clipsToBounds = YES;
    [headview addSubview:btn];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.headicon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([UIView setHeight:21]);
        make.left.equalTo([UIView setWidth:12]);
        make.width.height.equalTo([UIView setWidth:60]);
    }];
    [self.numLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headicon).offset([UIView setHeight:48]);
        make.centerX.equalTo(self.headicon);
        make.width.equalTo([UIView setWidth:50]);
        make.height.equalTo([UIView setHeight:15]);
    }];
    [self.idLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([UIView setHeight:31]);
        make.left.equalTo(self.headicon.right).offset([UIView setWidth:12]);
        make.right.equalTo(-WidthScale(120));
        
    }];
    [self.discipleNumLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idLabel.bottom).offset([UIView setHeight:12]);
        make.left.equalTo(self.idLabel);
    }];
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.discipleNumLabel);
        make.left.equalTo(self.discipleNumLabel.right).offset([UIView setWidth:14]);
        
    }];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-[UIView setWidth:12]);
        make.top.equalTo([UIView setHeight:50]);
        make.width.equalTo([UIView setWidth:95]);
        make.height.equalTo([UIView setHeight:35]);
    }];
    
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"每日排行" forState:UIControlStateNormal];
    [btn1 setTitleColor:SF_COLOR(195, 219, 255) forState:UIControlStateNormal];
    [btn1 setTitleColor:SF_COLOR(255, 255, 255) forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 330;
    btn1.selected = 1;
    [self.view addSubview:btn1];

    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"三角形"]];
    [btn1 addSubview:image1];
    image1.tag = 340;
    [image1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn1);
        make.bottom.equalTo(0);
        make.height.equalTo([UIView setHeight:8]);
        make.width.equalTo([UIView setWidth:16]);
    }];
 
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headview.bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(SWIDTH/2.f);
        make.height.equalTo([UIView setHeight:42]);
    }];
    
    UIButton *btn2 = [[UIButton alloc]init];
    [btn2 setTitle:@"总计排行" forState:UIControlStateNormal];
    [btn2 setTitleColor:SF_COLOR(195, 219, 255) forState:UIControlStateNormal];
    [btn2 setTitleColor:SF_COLOR(255, 255, 255) forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 331;
    btn2.selected = 0;
    [self.view addSubview:btn2];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];

    [btn2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headview.bottom);
        make.left.equalTo(btn1.right);
        make.width.equalTo(SWIDTH/2.f);
        make.height.equalTo([UIView setHeight:42]);
    }];
    
    UIImageView *image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"三角形"]];
    [btn2 addSubview:image2];
    image2.tag = 341;
    [image2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn2);
        make.bottom.equalTo(0);
        make.height.equalTo([UIView setHeight:8]);
        make.width.equalTo([UIView setWidth:0]);
    }];
    
    btn1.backgroundColor = SF_COLOR(28, 108, 229);
    btn2.backgroundColor = SF_COLOR(28, 108, 229);
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+[UIView setHeight:148], SWIDTH, SHEIGHT-64-[UIView setHeight:148]) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.table registerClass:[ChartsTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.table];
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isDayRank) {
        return _dayRankArr.count;
    } else {
        return _allRankArr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:88];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isDayRank) {
        
    }
    ChartsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell reloadWithIndex:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rankDic = _isDayRank ? self.dayRankArr[indexPath.row] : self.allRankArr[indexPath.row];
    return cell;
}

- (void)btnclick {
    NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"2"}];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}
- (void)btnclick:(UIButton *)btn {
    if (btn.selected) {
        return;
    }
    btn.selected = 1;
    UIImageView *image1 = (UIImageView *)[self.view viewWithTag:btn.tag+10];
    [image1 updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([UIView setWidth:16]);
    }];
    
    UIImageView *image2 = (UIImageView *)[self.view viewWithTag:!(btn.tag-330)+340];
    [image2 updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([UIView setWidth:0]);

    }];
    
    switch (btn.tag) {
        case 330:
            _isDayRank = YES;
            break;
        case 331:
            _isDayRank = NO;
            break;
            
        default:
            break;
    }
    [self.table reloadData];
    
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:330+!(btn.tag-330)];
    btn1.selected = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据请求
- (void)requestRankData{
    [RequestData PostDataWithURL:KrankList parameters:@{@"uid": _delegate.uid} sucsess:^(id response) {
        DLog(@"%@", response);
        
        self.allRankArr = [NSArray arrayWithArray:response[@"data"][@"all"]];
        self.dayRankArr = [NSArray arrayWithArray:response[@"data"][@"day"]];
        
        self.discipleNumLabel.text = [NSString stringWithFormat:@"徒弟:%@", response[@"data"][@"invite_all_count"]];
        self.moneyLabel.text = @"";
        
        [self.table reloadData];
    } fail:^(NSError *error) {
        DLog(@"%@", error);
    } andViewController:self];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
