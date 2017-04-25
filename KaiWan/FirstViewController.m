//
//  FirstViewController.m
//  KaiWan
//
//  Created by chenguang on 17/3/2.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "FirstViewController.h"
#import "YYCollectionViewCell.h"
#import "ChartsViewController.h"
#import "LimitViewController.h"
#import "MakeDiscipleViewController.h"
#import "PostPhoneViewController.h"
#import "WithDrawMethodViewController.h"
#import "DeepTaskDetailViewController.h"
#import "HighTaskDetailViewController.h"
#import "CommentTaskDetailViewController.h"
#import "TimeLimitedTaskDetailViewController.h"
#import "SignInViewController.h"
#import <AdSupport/ASIdentifierManager.h>
#import "BangDViewController.h"
#import "TaskListViewController.h"


@interface FirstViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UIImageView *iconImage;
@property (nonatomic, strong)UILabel *syLabel;
@property (nonatomic, strong)UILabel *stLabel;
@property (nonatomic, strong)UILabel *IDLabel;
@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)NSMutableArray *scrlDataArray;
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.scrlDataArray = [NSMutableArray array];

    [self creatUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self relaod];
}
- (void)relaod {
   
    
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

    if (del.uid.length<=0) {
        self.syLabel.text = @"今日收益：0";
        self.stLabel.text = @"今日收徒：0";
        self.moneyLabel.text = @"0";
        return;
    }
    [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@index.html?uid=%@",HostUrl,del.uid] parameters:nil sucsess:^(id response) {
        NSDictionary *dic=(NSDictionary *)response;
        NSDictionary *data = dic[@"data"];
        NSDictionary *dica = data[@"user"];
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,dica[@"avatar"]]]];
        del.headIcon = [NSString stringWithFormat:@"%@%@",ImageUrl,dica[@"avatar"]];
        NSString *systr = [NSString creatWithId:dica[@"money_day_sum"]];
        self.syLabel.text = [NSString stringWithFormat:@"今日收益：%@",systr];
        
        NSString *mobile = [NSString creatWithId:dica[@"is_mobile"]];
        if (mobile.integerValue==1) {
            del.is_mobile = YES;
        }else {
            del.is_mobile = NO;
        }
        
        NSString *ststr = [NSString creatWithId:dica[@"day_count_e"]];
        self.stLabel.text = [NSString stringWithFormat:@"今日收徒：%@",ststr];
        
        self.IDLabel.text = [NSString stringWithFormat:@"ID：%@",del.uid];
        NSString *moneystr = [NSString creatWithId:dica[@"money_sum"]];
        self.moneyLabel.text = [NSString stringWithFormat:@"%@",moneystr];
        NSArray *arr = data[@"banner"];
        [self.scrlDataArray removeAllObjects];
        for (NSDictionary *dic in arr) {
            NSString *str = [NSString stringWithFormat:@"%@%@",ImageUrl,dic[@"img"]];
            [self.scrlDataArray addObject:str];
        }
        
        [self.collectionView reloadData];

    } fail:^(NSError *error) {
        
    } andViewController:self];
}
- (void)creatUI {
    //背景图
    UIImageView *headImage = [[UIImageView alloc]init];
    headImage.image = [UIImage imageNamed:@"背景"];
    [self.view addSubview:headImage];
    [headImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(0);
        make.height.equalTo(20+[UIView setHeight:187]);
    }];
    
    
    //头像
    self.iconImage = [[UIImageView alloc]init];
    _iconImage.backgroundColor = [UIColor whiteColor];
    self.iconImage.layer.borderColor = [RGBColor colorWithHexString:@"#68a1f6"].CGColor;
    self.iconImage.layer.borderWidth = 2.0;
    self.iconImage.clipsToBounds = YES;
    self.iconImage.layer.cornerRadius = [UIView setWidth:30];
    [headImage addSubview:_iconImage];
    [self.iconImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20+[UIView setHeight:15]);
        make.height.width.equalTo([UIView setWidth:60]);
        make.left.equalTo([UIView setWidth:12]);
    }];
    
    
    //收益
    self.syLabel = [[UILabel alloc]init];
    self.syLabel.textColor = [RGBColor colorWithHexString:@"#ecf1fc"];
    [headImage addSubview:self.syLabel];
    self.syLabel.font = [UIFont systemFontOfSize:14];
    [self.syLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImage.right).offset([UIView setWidth:15]);
        make.top.equalTo(_iconImage.top).offset([UIView setHeight:15]);
//        make.height.equalTo([UIView setHeight:14]);
        
    }];
    
    [self.syLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    
    
    //收徒
    self.stLabel = [[UILabel alloc]init];
    self.stLabel.textColor =[RGBColor colorWithHexString:@"#ecf1fc"];
    self.stLabel.font = [UIFont systemFontOfSize:14];
    [headImage addSubview:self.stLabel];
    [self.stLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.syLabel.left);
        make.height.equalTo(self.syLabel.height);
        make.top.equalTo(self.syLabel.bottom).with.offset([UIView setHeight:8]);
    }];
    [self.stLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    
    //箭头
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageNamed:@"首页-箭头"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [headImage addSubview:btn];
    
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20+[UIView setHeight:34]);
        make.right.equalTo(-[UIView setWidth:6]);
    }];
    
    self.IDLabel = [[UILabel alloc]init];
    self.IDLabel.textColor = [UIColor whiteColor];
    self.IDLabel.font = [UIFont systemFontOfSize:14];
    self.IDLabel.textAlignment = NSTextAlignmentRight;
    self.IDLabel.text = @"ID:12312312";
    [headImage addSubview:self.IDLabel];
    
    [self.IDLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn);
        make.right.equalTo(btn.left);
    }];
    
    UILabel *linelabel = [[UILabel alloc]init];
    linelabel.backgroundColor = [RGBColor colorWithHexString:@"#387ceb"];
    [headImage addSubview:linelabel];
    
    [linelabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImage.bottom).offset([UIView setHeight:10]);
        make.width.equalTo(SWIDTH);
        make.height.equalTo(1);
    }];
    
    
    
    //钱
    self.moneyLabel = [[UILabel alloc]init];
    self.moneyLabel.font = [UIFont systemFontOfSize:40];
    self.moneyLabel.textColor = [UIColor whiteColor];
    [headImage addSubview:self.moneyLabel];
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linelabel.bottom).offset([UIView setHeight:20]);
        make.left.equalTo(headImage).offset([UIView setWidth:12]);
    }];
    
    UIButton *txBtn = [[UIButton alloc]init];
    [txBtn setBackgroundImage:[UIImage imageNamed:@"首页-提现"] forState:UIControlStateNormal];
    [txBtn addTarget:self action:@selector(makeMoney) forControlEvents:UIControlEventTouchUpInside];
    [headImage addSubview:txBtn];
    headImage.userInteractionEnabled = YES;
    [txBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linelabel.bottom).offset([UIView setHeight:32]);
        make.right.equalTo(headImage).offset(-[UIView setWidth:12]);
    }];
    
    UIImageView *moneyImage = [[UIImageView alloc]init];
    moneyImage.image = [UIImage imageNamed:@"首页-收益"];
    [headImage addSubview:moneyImage];

    [moneyImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImage).offset([UIView setWidth:15]);
        make.bottom.equalTo(headImage.bottom).offset(-[UIView setHeight:7]);
    }];
    
    UILabel *zlabel = [[UILabel alloc]init];
    zlabel.textColor = [RGBColor colorWithHexString:@"#ecf1fc"];
    zlabel.font = [UIFont systemFontOfSize:14];
    zlabel.text = @"总共收益(元)";
    [headImage addSubview:zlabel];
    [zlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyImage.right).offset([UIView setWidth:2]);
        make.bottom.equalTo(headImage.bottom).offset(-[UIView setHeight:7]);
    }];
    
    
    //banner 图
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SWIDTH, [UIView setHeight:122]);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20+[UIView setHeight:187], SWIDTH, [UIView setHeight:122]) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collectionView];
    
    _collectionView=collectionView;
    
    [self.collectionView registerClass:[YYCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [UIView setHeight:110], SWIDTH, [UIView setHeight:10])];
    
    pageControl.pageIndicatorTintColor = SF_COLOR(255, 215, 223);
    pageControl.currentPageIndicatorTintColor = SF_COLOR(255, 54, 96);
    pageControl.enabled = NO;
    
    _pageControl=pageControl;
    
    
    [self addTimer];
    

    CGFloat heght = CGRectGetMaxY(self.collectionView.frame);
    
    
    //按钮;
    NSArray *imageArr = @[@"首页-快速任务",@"首页-好评任务",@"首页-联盟任务",@"首页-深度任务",@"首页-高额任务",@"首页-一元夺宝",@"首页-收徒任务",@"首页-签到任务",@"首页-排行榜",@"首页-敬请期待"];
    NSArray *titleArr = @[@"快速任务",@"好评任务",@"联盟任务",@"深度任务",@"高额任务",@"一元夺宝",@"收徒任务",@"签到任务",@"排行榜",@"敬请期待"];
    for (int i = 0; i < 12; i++) {
        
        UIButton *litBtn = [[UIButton alloc]init];
        if (i < 4) {
            litBtn.frame = CGRectMake(0+i*SWIDTH/4, heght+[UIView setHeight:4], SWIDTH/4, [UIView setHeight:88]);
        }
        if (i<8&&i>3) {
            litBtn.frame =CGRectMake(0+(i-4)*SWIDTH/4, heght + [UIView setHeight:92], SWIDTH/4, [UIView setHeight:88]);
        }
        if (i>7) {
            litBtn.frame =CGRectMake(0+(i-8)*SWIDTH/4, heght + [UIView setHeight:180], SWIDTH/4, [UIView setHeight:88]);
        }
        litBtn.layer.borderColor = [RGBColor colorWithHexString:@"#d6d6d6"].CGColor;
        litBtn.layer.borderWidth = 1;
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((SWIDTH/4-[UIView setWidth:35])/2, [UIView setHeight:16], [UIView setWidth:35], [UIView setHeight:35])];
        if (i<10) {
            image.image = [UIImage imageNamed:imageArr[i]];
        }
        
        [litBtn addSubview:image];
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIView setHeight:61], SWIDTH/4, [UIView setHeight:16])];
        
        titlelabel.textColor = [UIColor blackColor];
        titlelabel.textAlignment = NSTextAlignmentCenter;
        titlelabel.font = [UIFont systemFontOfSize:14];
        if (i<10) {
            titlelabel.text = titleArr[i];
        }
        [litBtn addSubview:titlelabel];
        
        litBtn.tag = 200+i;
        [litBtn addTarget:self action:@selector(litbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:litBtn];
    }
    
}
- (void)litbtnClick:(UIButton *)btn {
    
    
    
    switch (btn.tag-200) {
        case 0://快速任务，跳到“赚钱”
        {
            NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"2"}];
            [[NSNotificationCenter defaultCenter] postNotification:notice];
        }
            
            break;
            
        case 1: case 2: case 3: case 4://各种任务
        {
            TaskListViewController *taskListVC = [[TaskListViewController alloc] init];
            taskListVC.taskTag = btn.tag - 200;
            [self.navigationController pushViewController:taskListVC animated:YES];
        }
            break;
        case 5:
            //一元夺宝
            break;
        case 6:
            //收徒任务
            
            break;
        case 7:
            //签到任务
            [self.navigationController pushViewController:[[SignInViewController alloc] init] animated:YES];
            
            break;
        case 8:
            //排行榜
            [self.navigationController pushViewController:[[ChartsViewController alloc] init] animated:YES];

            break;
            
        default:
            break;
    }
    
}
-(void) addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer ;
    
}

#pragma mark 删除
-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void) nextpage{
    
    if (!self.scrlDataArray.count) {
        return;
    }
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:100/2];
    
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item +1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem==self.scrlDataArray.count) {
        nextItem=0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 100;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.scrlDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    if(!cell){
        cell = [[YYCollectionViewCell alloc] init];
    }
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.scrlDataArray[indexPath.item]]];
    return cell;
    
}


-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

#pragma mark 当用户停止的时候调用
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
    
}

#pragma mark 设置页码
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{

    int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.scrlDataArray.count;
    self.pageControl.currentPage =page;
}

#pragma mark--提现
- (void)makeMoney {
    
    [self.navigationController pushViewController:[[WithDrawMethodViewController alloc]init] animated:YES];

    
}
#pragma mark--ID按钮
- (void)clickBtn {
    
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
