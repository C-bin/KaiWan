
//
//  TaskListViewController.m
//  KaiWan 
//
//  Created by van7ish on 2017/4/24.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TaskListViewController.h"
#import "SecondTableViewCell.h"
#import "DeepTaskDetailViewController.h"
#import "TimeLimitedTaskDetailViewController.h"
#import "CommentTaskDetailViewController.h"
#import "HighTaskDetailViewController.h"

@interface TaskListViewController () <UITableViewDelegate, UITableViewDataSource>
{
    AppDelegate *_delegate;
}

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataArr;
@property (nonatomic,strong) UILabel *priceLabel;

@end

@implementation TaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.titlestring = @"任务列表";
    [self setNavigationBar];
    
    [self creatTB];
    [self requestDataWithTaskTag:_taskTag];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 数据请求
- (void)requestDataWithTaskTag:(TaskTag)taskTag {
    
    NSString *url;
    
    switch (taskTag) {
        case TaskTagTimeLimited:
            
            return;
        case TaskTagDeep:
            url = KdeepTaskList;
            return;
        case TaskTagHigh:
            url = KhighTaskList;
            break;
        case TaskTagUnion:
            url = KunionTaskList;
            break;
        case TaskTagComment:
            url = KcommentTaskList;
            break;
        default:
            break;
    }

    
    self.dataArr = [NSMutableArray array];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [RequestData GetDataWithURL:url parameters:@{@"uid": _delegate.uid} sucsess:^(id response) {
            
            
            
            self.dataArr = [NSArray arrayWithArray:response[@"data"]];
        
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];

        } fail:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
        } andViewController:self];
    }];
    
    [self.tableView.mj_header beginRefreshing];
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
    
    return self.dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell reloadWithDic:self.dataArr[indexPath.row]];
    
    
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
            make.right.equalTo(yimage.right).offset([UIView setWidth:3]);
            make.width.and.height.equalTo([UIView setHeight:20]);
        }];
        
        UILabel *plabel = [[UILabel alloc]init];
        plabel.text = @"5.00";
        plabel.textColor = SF_COLOR(28, 108, 229);
        plabel.font = [UIFont systemFontOfSize:25];
        [yimage addSubview:plabel];
        plabel.textAlignment = NSTextAlignmentRight;
        [plabel makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(reimage.left).offset([UIView setWidth:2]);
            make.centerY.equalTo(yimage.centerY);
        }];
        
        
    }
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //-98=无状态,0=点击（已领取），1 = 已完成 ，4 = 等待审核
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
    NSDictionary *dic = self.dataArr[indexPath.row];
    NSString *tid = [NSString creatWithId:dic[@"tid"]];
    NSString *status = [NSString creatWithId:dic[@"status"]];
    //1 = 已完成 ，4 = 等待审核 不会跳转详情页
    if (status.intValue==4||status.intValue==1) {
        return;
    }
    //正在进行的任务可以跳转详情，任务预告不会
    if (indexPath.section==0) {
        switch (tid.intValue) {
            case 50:
            {
                CommentTaskDetailViewController *commentTaskVC = [[CommentTaskDetailViewController alloc] init];
                commentTaskVC.taskDic = self.dataArr[indexPath.row];
                [self.navigationController pushViewController:commentTaskVC animated:YES];
            }
                break;
            case 51:
            {
                HighTaskDetailViewController *highTaskDetailVC = [[HighTaskDetailViewController alloc] init];
                highTaskDetailVC.taskDic = self.dataArr[indexPath.row];
                [self.navigationController pushViewController:highTaskDetailVC animated:YES];
            }
                break;
            case 55:
            {
                DeepTaskDetailViewController *deepTaskDetailVC = [[DeepTaskDetailViewController alloc] init];
                deepTaskDetailVC.taskDic = self.dataArr[indexPath.row];
                [self.navigationController pushViewController:deepTaskDetailVC animated:YES];
            }
                break;
            case 7:
            {
                TimeLimitedTaskDetailViewController *limitedTaskVC = [[TimeLimitedTaskDetailViewController alloc] init];
                limitedTaskVC.taskDic = self.dataArr[indexPath.row];
                limitedTaskVC.type = 1;
                [self.navigationController pushViewController:limitedTaskVC animated:YES];
            }
                break;
                
            case 58:
            {
                TimeLimitedTaskDetailViewController *timeLimitedVC = [[TimeLimitedTaskDetailViewController alloc] init];
                timeLimitedVC.taskDic = self.dataArr[indexPath.row];
                timeLimitedVC.type = 2;
                [self.navigationController pushViewController:timeLimitedVC animated:YES];
            }
                
            default:
                break;
        }
    }
}


@end
