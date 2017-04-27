//
//  MakeViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/5.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "MakeViewController.h"
#import "MakeTableViewCell.h"
#import "MakeModel.h"
@interface MakeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tabel;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, assign)int page;
@property (nonatomic, strong) UIImageView * nullImageView;

@end

@implementation MakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.titlestring = @"任务收入";
    [self setNavigationBar];
    [self creatUI];
    [self reload];
}
- (void)creatUI {
    self.tabel = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64) style:UITableViewStylePlain];
    self.tabel.delegate = self;
    self.tabel.dataSource = self;
    self.tabel.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tabel registerClass:[MakeTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tabel];
    
    
}
- (void)reload {
    self.dataArray = [NSMutableArray array];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

    self.tabel.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@User/task.html?uid=%@&page=%d",HostUrl,del.uid,self.page] parameters:nil sucsess:^(id response) {
            [self.tabel.mj_header endRefreshing];
            NSDictionary *dic = (NSDictionary *)response;
            NSDictionary *data = dic[@"data"];
            NSArray *arr = data[@"list"];
            if (arr.count>0) {
                [self.dataArray removeAllObjects];
                if (_nullImageView) {
                    [_nullImageView removeFromSuperview];    
                }
                
            } else {
                _nullImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SWIDTH - WidthScale(180)) / 2, (SHEIGHT - HeightScale(160)) / 2, WidthScale(180), HeightScale(160))];
                _nullImageView.image = [UIImage imageNamed:@"暂无记录"];
                [self.view addSubview:_nullImageView];
            }
            
            for (NSDictionary *dic in arr) {
                MakeModel *model = [[MakeModel alloc]initWithDictionary:dic error:nil];
                [self.dataArray addObject:model];
            }[self.tabel reloadData];
            
        } fail:^(NSError *error) {
            [self.tabel.mj_header endRefreshing];
            
        } andViewController:nil];
    }];
    
    [self.tabel.mj_header beginRefreshing];
    
    self.tabel.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@User/task.html?uid=%@&page=%d",HostUrl,del.uid,self.page] parameters:nil sucsess:^(id response) {
            [self.tabel.mj_footer endRefreshing];
            NSDictionary *dic = (NSDictionary *)response;
            NSDictionary *data = dic[@"data"];
            NSArray *arr = data[@"list"];
            if (arr.count==0) {
                [self.tabel.mj_footer endRefreshingWithNoMoreData];
            }
            for (NSDictionary *dic in arr) {
                MakeModel *model = [[MakeModel alloc]initWithDictionary:dic error:nil];
                [self.dataArray addObject:model];
            }[self.tabel reloadData];
            
        } fail:^(NSError *error) {
            [self.tabel.mj_footer endRefreshing];
            
        } andViewController:nil];
    }];
    self.tabel.mj_footer.hidden = YES;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tabel.mj_footer.hidden=self.dataArray.count==0;
    return self.dataArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
       MakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell reloadWith:self.dataArray[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:60];
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
