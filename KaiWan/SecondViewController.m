//
//  SecondViewController.m
//  KaiWan
//
//  Created by chenguang on 17/3/2.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondTableViewCell.h"
#import "DeepTaskDetailViewController.h"
#import "TimeLimitedTaskDetailViewController.h"
#import "CommentTaskDetailViewController.h"
#import "HighTaskDetailViewController.h"
#import "PostPhoneViewController.h"
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic,strong) UILabel *priceLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.titlestring = @"任务列表";
    [self setNavigationBar];
    [self creatTB];
    [self request];
    

}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}
- (void)request {
    self.dataArr = [NSMutableArray array];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

        [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Task.html?uid=%@",HostUrl,del.uid] parameters:nil sucsess:^(id response) {
            
            NSDictionary *dic = (NSDictionary *)response;
            NSDictionary *data = dic[@"data"];
            NSArray *arr1 = data[@"show"];
            NSArray *arr2 = data[@"hide"];
            
            [self.dataArr removeAllObjects];
            
            [self.dataArr addObject:arr1];
            [self.dataArr addObject:arr2];
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            int totalPrice = 0 ;
            if (arr2.count>0) {
                for (NSDictionary *appdic in arr2) {
                    NSString *price = [NSString creatWithId:appdic[@"reward"]];
                    totalPrice += price.intValue;
                }
                self.priceLabel.text = [NSString stringWithFormat:@"精彩预告,一大波任务即将开始，共%d元！",totalPrice];
            }
        } fail:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
        } andViewController:self];
    }];
    
}
- (void)creatTB {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64-49) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = SF_COLOR(235, 235, 235);
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArr[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [ cell reloadWithDic:self.dataArr[indexPath.section][indexPath.row] ];
    
    
    return cell;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
       return [UIView setHeight:141];
    }else {
        return [UIView setHeight:40];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:83];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    if (section == 0) {
        view.frame = [UIView setRectWithX:0 andY:0 andWidth:375 andHeight:48+85+8];
        view.backgroundColor = SF_COLOR(235, 235, 235);
        UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:10 andWidth:375-24 andHeight:28]];
        image.image = [UIImage imageNamed:@"列表-虚线框"];
        [view addSubview:image];
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:20 andY:4 andWidth:20 andHeight:20]];
        icon.image = [UIImage imageNamed:@"列表-通知"];
        [image addSubview:icon];
        
        UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:46 andY:0 andWidth:300 andHeight:28]];
        label.text = @"每天15:00～18:00任务多多，50元大钞等你赚";
        label.textColor = SF_COLOR(219, 3, 3);
        label.font = [UIFont systemFontOfSize:13];
        [image addSubview:label];
        
        UIImageView *yimage = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:48 andWidth:375-24 andHeight:85]];
        yimage.image = [UIImage imageNamed:@"列表-邀请背景"];
        [view addSubview:yimage];
        
        UIImageView *iconimage = [[UIImageView alloc]init];
        iconimage.image = [UIImage imageNamed:@"列表-邀请好友"];
        [yimage addSubview:iconimage];
        
        [iconimage makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(yimage);
            make.left.equalTo(yimage.left).offset([UIView setWidth:10]);
            make.width.height.equalTo([UIView setHeight:50]);
        }];
        
        UILabel *titlelabel = [[UILabel alloc]init];
        titlelabel.text = @"邀请好友";
        titlelabel.font = [UIFont systemFontOfSize:18];
        titlelabel.textColor = [UIColor blackColor];
        [yimage addSubview:titlelabel];
        
        [titlelabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconimage.right).offset([UIView setWidth:10]);
            make.top.equalTo([UIView setHeight:22]);
            
        }];
        
        UILabel *tlabel = [[UILabel alloc]init];
        tlabel.text = @" 徒弟遍天下，数钱到天亮 ";
        tlabel.textColor = SF_COLOR(90, 156, 255);
        tlabel.font = [UIFont systemFontOfSize:12];
        tlabel.layer.borderColor = SF_COLOR(90, 156, 255).CGColor;
        tlabel.layer.borderWidth = 0.5;
        tlabel.layer.cornerRadius = 2;
        tlabel.clipsToBounds = YES;
        [yimage addSubview:tlabel];
        
        
        [tlabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titlelabel.left);
            make.top.equalTo(titlelabel.bottom).offset([UIView setHeight:8]);
            make.height.equalTo([UIView setHeight:14]);
            
        }];
        
        UIImageView *reimage = [[UIImageView alloc]init];
        reimage.image = [UIImage imageNamed:@"列表-邀请箭头"];
        [yimage addSubview:reimage];
        
        [reimage makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(yimage.centerY);
            make.right.equalTo(yimage.right).offset(-[UIView setWidth:3]);
            make.width.and.height.equalTo([UIView setHeight:20]);
        }];
        
        UILabel *plabel = [[UILabel alloc]init];
        plabel.text = @"5.00";
        plabel.textColor = SF_COLOR(28, 108, 229);
        plabel.font = [UIFont systemFontOfSize:25];
        [yimage addSubview:plabel];
        plabel.textAlignment = NSTextAlignmentRight;
        [plabel makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(reimage.left).offset(-[UIView setWidth:2]);
            make.centerY.equalTo(yimage.centerY);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushThirdVc:)];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:tap];
        
        
    }
    if (section == 1) {
        view.frame = [UIView setRectWithX:0 andY:0 andWidth:375 andHeight:40];
        view.backgroundColor = SF_COLOR(235, 235, 235);
        UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:2 andWidth:375-24 andHeight:28]];
        image.image = [UIImage imageNamed:@"列表-虚线框"];
        [view addSubview:image];
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:20 andY:4 andWidth:20 andHeight:20]];
        icon.image = [UIImage imageNamed:@"列表-通知"];
        [image addSubview:icon];
        
        self.priceLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:46 andY:0 andWidth:300 andHeight:28]];
        self.priceLabel.text = @"精彩预告,一大波任务即将开始，共0元！";
        self.priceLabel.textColor = SF_COLOR(219, 3, 3);
        self.priceLabel.font = [UIFont systemFontOfSize:13];
        [image addSubview:self.priceLabel];
 
    }
    return view;
}
- (void)pushThirdVc:(UITapGestureRecognizer *)tap {
    NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"3"}];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //-98=无状态,0=点击（已领取），1 = 已完成 ，4 = 等待审核 5 = 审核未通过
    //好评任务50,高额任务51,深度任务55,限时任务 7
    
    /*  dic里包含的数据;
     tid: 50,
     reward: "1",
     img: "app/artwork/517/64/47/58ef2dc43d70beb97e.jpg",
     status: -98,
     appid: 517644732,
     amount: 1,
     click: 0,
     keywords: "万达电影",
     start_time: 1492012809,
     end_time: 1492272009
     */
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

    if (!del.is_mobile) {
        [self.navigationController pushViewController:[[PostPhoneViewController alloc]init] animated:YES];
        return;
    }
    NSDictionary *dic = self.dataArr[0][indexPath.row];
    NSString *tid = [NSString creatWithId:dic[@"tid"]];
    NSString *status = [NSString creatWithId:dic[@"status"]];
    //1 = 已完成 ，4 = 等待审核 5 = 审核未通过 不会跳转详情页
    if (status.intValue==4||status.intValue==1||status.intValue==5) {
        return;
    }
    
    //任务数量为0 并且 状态等于-98 ，则不能点击进入详情页
    if (([self.dataArr[0][indexPath.row][@"amount"] intValue] <= 0) && [self.dataArr[0][indexPath.row][@"status"] intValue] == -98) {
        return;
    }
    //正在进行的任务可以跳转详情，任务预告不会
    if (indexPath.section==0) {
        switch (tid.intValue) {
            case 50:
            {
                CommentTaskDetailViewController *commentTaskVC = [[CommentTaskDetailViewController alloc] init];
                commentTaskVC.taskDic = self.dataArr[0][indexPath.row];
                [self.navigationController pushViewController:commentTaskVC animated:YES];
            }
                
                break;
            case 51:
            {
                HighTaskDetailViewController *highTaskDetailVC = [[HighTaskDetailViewController alloc] init];
                highTaskDetailVC.taskDic = self.dataArr[0][indexPath.row];
                [self.navigationController pushViewController:highTaskDetailVC animated:YES];
            }
                break;
            case 55:
            {
                DeepTaskDetailViewController *deepTaskDetailVC = [[DeepTaskDetailViewController alloc] init];
                deepTaskDetailVC.taskDic = self.dataArr[0][indexPath.row];
                [self.navigationController pushViewController:deepTaskDetailVC animated:YES];
            }
                break;
            case 7:
            {
                TimeLimitedTaskDetailViewController *limitedTaskVC = [[TimeLimitedTaskDetailViewController alloc] init];
                limitedTaskVC.taskDic = self.dataArr[0][indexPath.row];
                limitedTaskVC.type = 1;
                [self.navigationController pushViewController:limitedTaskVC animated:YES];
            }
                break;
            case 58:
            {
                TimeLimitedTaskDetailViewController *timeLimitedVC = [[TimeLimitedTaskDetailViewController alloc] init];
                timeLimitedVC.taskDic = self.dataArr[0][indexPath.row];
                timeLimitedVC.type = 2;
                [self.navigationController pushViewController:timeLimitedVC animated:YES];
            }
                
                
            default:
                break;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
