//
//  QuestionViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/19.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *seletArr;

@property (nonatomic,strong) NSArray *titleArr;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"疑难解答";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavigationBar];
    self.seletArr = [NSMutableArray array];
    self.titleArr = @[@"1.打开“开玩”APP，进入任务页面\n2.按照任务步骤和要求，记住任务图标和位置，复制关键字提跳转至App Store\n3.在App Store搜索框粘贴关键字，并找到任务对应图标进行下载\n4.下载成功后，按要求试玩3分钟，回答任务页面点击提交审核，领取奖励。",@"1.周一到周四提现，一般48小时内到账；\n2.周五至周日提现，会同意在下周一审核，一般审核后48小时可以到账；\n3.节假日延期。\n注：所有打款都为人工审核，一旦发现作弊将取消打款",@"1.如点击微信登录后没有反应，则检查是否有网络连接，如果是WiFi情况下登录不上，则可切换到4G状态下进行登录。\n2.如果登录时提示“设备发生变化”，请及时联系客服进行解决。\n3.如登录成功后发现与原账户不一致，请通过联系客服提供老账户绑定的手机号或支付宝账号进行找回。请加群找管理员解决，QQ群：368880613",@"1.每日任务集中发布时间段为16点到21点、\n2.已经做过的任务将不再重复显示。\n3.苹果系统版本过低，请更新版本。",@"1.越狱和还原广告标识符的用户系统会自动将账户禁用，账户将暂时无法使用。\n2.当发现用户通过刷机等作弊形式进行收徒等行为时，将禁用该账户。"];
    for (int i = 0; i < 5; i++) {
        NSString *str = @"0";
        [self.seletArr addObject:str];
    }
    [self setUI];
}
- (void)setUI {
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64) style:UITableViewStylePlain];
    self.table.delegate = self;
//    self.table.backgroundColor  = [UIColor redColor];
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    self.table.backgroundColor = SF_COLOR(235, 235, 235);
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.seletArr[section] isEqualToString:@"1"]) {
        return 1;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UILabel  *label = [UILabel creatLabelWithFont:15 andbgcolor:SF_COLOR(235, 235, 235) andtextColor:SF_COLOR(102, 102, 102) andAligment:0];
    label.frame = [UIView setRectWithX:12 andY:12 andWidth:375-24 andHeight:1000];
    label.text = self.titleArr[indexPath.section];
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat hei = label.bounds.size.height;
    return hei+[UIView setHeight:24];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
   
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];;
        UILabel  *label = [UILabel creatLabelWithFont:15 andbgcolor:SF_COLOR(235, 235, 235) andtextColor:SF_COLOR(102, 102, 102) andAligment:0];
        label.frame = [UIView setRectWithX:12 andY:12 andWidth:375-24 andHeight:0];
        [cell.contentView addSubview:label];
        
        label.tag = 789;
        
        
    }
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:789];
    label.text = self.titleArr[indexPath.section];
    label.numberOfLines = 0;
    [label sizeToFit];
    cell.backgroundColor = SF_COLOR(235, 235, 235);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray *arr = @[@"一、试玩须知",@"二、提现问题",@"三、登录问题",@"四、看不到任务问题",@"五、作弊问题"];
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:50]];
    UILabel *label = [UILabel creatLabelWithFont:17 andbgcolor:nil andtextColor:SF_COLOR(51, 51, 51) andAligment:0];
    label.text = arr[section];
//    view.backgroundColor = [UIColor redColor];
    [view addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, WidthScale(12), 0, 0));
    }];
    view.tag = 660+section;
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightScale(50)-1, SWIDTH, 1)];
    linelabel.backgroundColor = SF_COLOR(232, 232, 232);
    [view addSubview:linelabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
    
    [view addGestureRecognizer:tap];
    UIImageView *image = [[UIImageView alloc]init];
    [view addSubview:image];
    
    [image makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(-WidthScale(12));
        make.width.height.equalTo(HeightScale(22));
    }];
    if ([self.seletArr[section] isEqualToString:@"1"]) {
        image.image = [UIImage imageNamed:@"解答-展开"];

    }else {
        image.image = [UIImage imageNamed:@"解答-收起"];

    }
    
    
    return view;
}
- (void)tapclick:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag;
    NSString *str = self.seletArr[index-660];
    if ([str isEqualToString:@"1"]) {
        str = @"0";
        [self.seletArr replaceObjectAtIndex:index-660 withObject:str];
        [self.table reloadSections:[NSIndexSet indexSetWithIndex:index-660] withRowAnimation:UITableViewRowAnimationNone];

    }else {
        str = @"1";
        [self.seletArr replaceObjectAtIndex:index-660 withObject:str];

        [self.table reloadSections:[NSIndexSet indexSetWithIndex:index-660] withRowAnimation:UITableViewRowAnimationNone];

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeightScale(50);
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
