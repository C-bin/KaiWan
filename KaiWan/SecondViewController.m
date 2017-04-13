//
//  SecondViewController.m
//  KaiWan
//
//  Created by chenguang on 17/3/2.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondTableViewCell.h"
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.titlestring = @"任务列表";
    [self setNavigationBar];
    [self creatTB];
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
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
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
    if (section == 1) {
        view.frame = [UIView setRectWithX:0 andY:0 andWidth:375 andHeight:40];
        view.backgroundColor = SF_COLOR(235, 235, 235);
        UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:2 andWidth:375-24 andHeight:28]];
        image.image = [UIImage imageNamed:@"列表-虚线框"];
        [view addSubview:image];
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:20 andY:4 andWidth:20 andHeight:20]];
        icon.image = [UIImage imageNamed:@"列表-通知"];
        [image addSubview:icon];
        
        UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:46 andY:0 andWidth:300 andHeight:28]];
        label.text = @"精彩预告,一大波任务即将开始，共8877元！";
        label.textColor = SF_COLOR(219, 3, 3);
        label.font = [UIFont systemFontOfSize:13];
        [image addSubview:label];
 
    }
    return view;
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
