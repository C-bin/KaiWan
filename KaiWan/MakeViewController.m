//
//  MakeViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/5.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "MakeViewController.h"
#import "MakeTableViewCell.h"
@interface MakeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tabel;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation MakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titlestring = @"任务收入";
    [self setNavigationBar];
    [self creatUI];
    [self reload];
}
- (void)creatUI {
    self.tabel = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64-49) style:UITableViewStylePlain];
    self.tabel.delegate = self;
    self.tabel.dataSource = self;
    self.tabel.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tabel registerClass:[MakeTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tabel];
    
    
}
- (void)reload {
    self.dataArray = [NSMutableArray array];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataArray.count;
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
       MakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
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
