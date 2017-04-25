//
//  SonViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/5.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "SonViewController.h"
#import "SonTableViewCell.h"
@interface SonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, assign)int isInvite;

@end

@implementation SonViewController
{
    int page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"收徒记录";
    page=1;
    self.isInvite = 0;
    self.dataArray = [NSMutableArray array];
    [self setNavigationBar];
    [self setUI];
    [self request];
}
- (void)request {
    page = 1;
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArray removeAllObjects];
        [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Share/lst.html?uid=%@&page=%d",HostUrl,del.uid,page] parameters:nil sucsess:^(id response) {
            NSDictionary *dic = (NSDictionary *)response;
            NSDictionary *data = dic[@"data"];
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:data[@"invite"]];
            NSMutableArray *arr1 = [[NSMutableArray alloc]initWithArray:data[@"task"]];
            [self.dataArray addObject:arr];
            [self.dataArray addObject:arr1];
            [self.table.mj_header endRefreshing];
            [self.table reloadData];
        } fail:^(NSError *error) {
            [self.table.mj_header endRefreshing];

        } andViewController:nil];

    }];
    
    [self.table.mj_header beginRefreshing];
    
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Share/lst.html?uid=%@&page=%d",HostUrl,del.uid,page] parameters:nil sucsess:^(id response) {
            NSDictionary *dic = (NSDictionary *)response;
            NSDictionary *data = dic[@"data"];
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:data[@"invite"]];
            NSMutableArray *arr1 = [[NSMutableArray alloc]initWithArray:data[@"task"]];
            if (arr.count>0) {
                for (NSDictionary *dica in arr) {
                    [self.dataArray[0] addObject:dica];
                }
            }
            if (arr1.count>0) {
                for (NSDictionary *dica in arr1) {
                    [self.dataArray[1] addObject:dica];
                }
            }
            if (arr1.count==0&&arr.count==0) {
                [self.table.mj_footer endRefreshingWithNoMoreData];
            }
            [self.table reloadData];
            [self.table.mj_footer endRefreshing];
        } fail:^(NSError *error) {
            [self.table.mj_footer endRefreshing];
        } andViewController:nil];

    }];
    self.table.mj_footer.hidden = YES;
}
- (void)setUI {
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"徒弟记录" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:SF_COLOR(28, 108, 229) forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 310;
    btn1.selected = 1;
    [self.view addSubview:btn1];
    UILabel *linelabel1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:375/4.f-75/2.f andY:43 andWidth:75 andHeight:2]];
    linelabel1.backgroundColor = SF_COLOR(28, 108, 229);
    linelabel1.tag = 320;
    [btn1 addSubview:linelabel1];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview.bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(SWIDTH/2.f);
        make.height.equalTo([UIView setHeight:45]);
    }];
    
    UIButton *btn2 = [[UIButton alloc]init];
    [btn2 setTitle:@"徒弟收入" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:SF_COLOR(28, 108, 229) forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 311;
    btn2.selected = 0;
    [self.view addSubview:btn2];
    [btn2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview.bottom);
        make.left.equalTo(btn1.right);
        make.width.equalTo(SWIDTH/2.f);
        make.height.equalTo([UIView setHeight:45]);
    }];
    UILabel *linelabel2 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:375/4.f-75/2.f andY:43 andWidth:75 andHeight:2]];
    linelabel2.backgroundColor = [UIColor whiteColor];
    linelabel2.tag = 321;
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];

    [btn2 addSubview:linelabel2];
    btn2.backgroundColor = [UIColor whiteColor];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+[UIView setHeight:45+13], SWIDTH, SHEIGHT-64-[UIView setHeight:45+13]) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    [self.table registerClass:[SonTableViewCell class] forCellReuseIdentifier:@"cell"];
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:64+[UIView setHeight:45] andWidth:375 andHeight:13]];
    view.backgroundColor = SF_COLOR(242, 242, 242);
//    [self.view addSubview:view];
    
}
#pragma mark 输入切换
- (void)btnclick:(UIButton *)btn {
    if (btn.selected) {
        return;
    }
    self.isInvite = (int)(btn.tag-310);
    
    btn.selected = 1;
    UILabel *label = (UILabel *)[self.view viewWithTag:btn.tag+10];
    label.backgroundColor = SF_COLOR(28, 108, 229);
    
    UILabel *label2 = (UILabel *)[self.view viewWithTag:!(btn.tag-310)+320];
    label2.backgroundColor = [UIColor whiteColor];
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:310+!(btn.tag-310)];
    btn1.selected = 0;
    [self.table reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.table.mj_footer.hidden = self.dataArray.count == 0;

    if (self.dataArray.count>0) {
//        if ([self.dataArray[self.isInvite] count]==0) {
//            self.table.tableFooterView = [NoneListView creatNoneListViewWith:self.table];
//        }else {
//            self.table.tableFooterView = nil;
//        }
        NSMutableArray *arr = self.dataArray[self.isInvite];
        
        return arr.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:45];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       SonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell reloadwithDic:self.dataArray[self.isInvite][indexPath.row]  andIsInvite: self.isInvite];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:16]];
    return view;
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
