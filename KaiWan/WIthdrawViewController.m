//
//  WIthdrawViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/5.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "WIthdrawViewController.h"
#import "WithdrawTableViewCell.h"
#import "WIthDrawModel.h"
@interface WIthdrawViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) int page;
@property (nonatomic, strong) UIImageView * nullImageView;
@end

@implementation WIthdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"提现记录";
    [self setNavigationBar];
    [self creatUI];
    [self request];
    
    _nullImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SWIDTH - WidthScale(180)) / 2, (SHEIGHT - HeightScale(160)) / 2, WidthScale(180), HeightScale(160))];
    _nullImageView.image = [UIImage imageNamed:@"暂无记录"];
    
}
- (void)request {
    self.dataArray = [NSMutableArray array];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Deposit/lst.html?uid=%@&page=%d",HostUrl,del.uid,self.page] parameters:nil sucsess:^(id response) {
            [self.table.mj_header endRefreshing];
            NSDictionary *dic = (NSDictionary *)response;
            NSDictionary *data = dic[@"data"];
            NSArray *arr = data[@"lst"];
            if (arr.count>0) {
                [self.dataArray removeAllObjects];
                
                [_nullImageView removeFromSuperview];
                
            } else {
                
                [self.view addSubview:_nullImageView];
            }
            for (NSDictionary *dic in arr) {
                WIthDrawModel *model = [[WIthDrawModel alloc]initWithDictionary:dic error:nil];
                [self.dataArray addObject:model];
            }[self.table reloadData];
            
        } fail:^(NSError *error) {
            [self.table.mj_header endRefreshing];
            
        } andViewController:nil];
    }];
    
    [self.table.mj_header beginRefreshing];
    
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@User/task.html?uid=%@&page=%d",HostUrl,del.uid,self.page] parameters:nil sucsess:^(id response) {
            [self.table.mj_footer endRefreshing];
            NSDictionary *dic = (NSDictionary *)response;
            NSDictionary *data = dic[@"data"];
            NSArray *arr = data[@"list"];
            if (arr.count==0) {
                [self.table.mj_footer endRefreshingWithNoMoreData];
            }
            for (NSDictionary *dic in arr) {
                WIthDrawModel *model = [[WIthDrawModel alloc]initWithDictionary:dic error:nil];
                [self.dataArray addObject:model];
            }[self.table reloadData];
            
        } fail:^(NSError *error) {
            [self.table.mj_footer endRefreshing];
            
        } andViewController:nil];
    }];
    self.table.mj_footer.hidden = YES;

}
- (void)creatUI {
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.table registerClass:[WithdrawTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.table];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:60];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WithdrawTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell reloadWithModel:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
