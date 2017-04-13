//
//  DeepTaskDetailViewController.m
//  KaiWan
//
//  Created by van7ish on 2017/4/12.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "DeepTaskDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DeepTaskDetailViewController ()

@end

@implementation DeepTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titlestring = @"任务详情";
    [self setNavigationBar];
    [self createUI];
    
}

- (void)createUI{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, HeightScale(80))];
    infoView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:infoView];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(10), HeightScale(10), WidthScale(60), HeightScale(60))];
    iconImageView.image = [UIImage imageNamed:@"列表-问号"];
    [infoView addSubview:iconImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame) + WidthScale(10), iconImageView.frame.origin.y, WidthScale(200), HeightScale(30))];
    titleLabel.text = @"闲鱼二手交易";
    titleLabel.font = [UIFont systemFontOfSize:16];
    [infoView addSubview:titleLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, CGRectGetMaxY(titleLabel.frame), WidthScale(200), HeightScale(30))];
    
    NSDictionary *firstDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:WidthScale(15)], NSFontAttributeName, [UIColor colorWithWhite:0.6 alpha:1], NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *firstStr = [[NSMutableAttributedString alloc] initWithString:@"任务剩余时间:" attributes:firstDic];
    NSDictionary *secondDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:WidthScale(15)], NSFontAttributeName,
                                   [UIColor blueColor],NSForegroundColorAttributeName,nil];
    NSMutableAttributedString *secondStr = [[NSMutableAttributedString alloc]initWithString:@"29分21秒" attributes:secondDic];
    [firstStr appendAttributedString:secondStr];
    timeLabel.attributedText = firstStr;
    
    [infoView addSubview:timeLabel];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width - WidthScale(108), HeightScale(20), WidthScale(100), HeightScale(40))];
    moneyLabel.text = @"+1.20元";
    moneyLabel.textAlignment = NSTextAlignmentRight;
    moneyLabel.textColor = [UIColor redColor];
    moneyLabel.font = [UIFont systemFontOfSize:WidthScale(20)];
    [infoView addSubview:moneyLabel];
    
    UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(WidthScale(10), infoView.frame.size.height - HeightScale(1), SWIDTH - WidthScale(20), HeightScale(1))];
    underLine.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [infoView addSubview:underLine];
    
    UIView *stepView = [[UIView alloc] init];
    stepView.backgroundColor = [UIColor whiteColor];
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthScale(15), HeightScale(15), SWIDTH - WidthScale(20), HeightScale(200))];
    
    [scrollView addSubview:stepView];
    
    NSString *str = @"参与步骤:\n1.复制下方关键字，在App Store搜索下载，找到下面对应图标，约在第3名下载;\n2.下载成功后，打开试玩3分钟;\n3.返回本页提交任务，领取奖励。";
    
    // 创建 NSMutableAttributedString
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    // 设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:WidthScale(20)]
                    range:NSMakeRange(0, 5)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:WidthScale(16)] range:NSMakeRange(5, [str length] - 5)];
    // 添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]
                    range:NSMakeRange(43, 1)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]
                    range:NSMakeRange(59, 5)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]
                    range:NSMakeRange(68, 4)];


    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
    
    // 自动换行
    stepLabel.numberOfLines = 0;
    // 设置label的富文本
    stepLabel.attributedText = attrStr;
    // label高度自适应
    [stepLabel sizeToFit];
    
    [stepView addSubview:stepLabel];
    stepView.frame = CGRectMake(0, CGRectGetMaxY(infoView.frame), SWIDTH, stepLabel.frame.size.height + HeightScale(30));
    
    UIView *step1View = [[UIView alloc]  initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(stepView.frame) + HeightScale(20), SWIDTH - WidthScale(30), SWIDTH / 1.7)];
    step1View.backgroundColor = [UIColor whiteColor];
    step1View.layer.cornerRadius = WidthScale(8);
    UIImageView *step1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(-2), HeightScale(15), WidthScale(67), HeightScale(30))];
    step1ImageView.image = [UIImage imageNamed:@"步骤一"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((step1View.frame.size.width - WidthScale(70)) / 2, HeightScale(30), WidthScale(70), HeightScale(70))];
    imageView.image = [UIImage imageNamed:@"列表-问号"];
    
    UILabel *rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), step1View.frame.size.width, HeightScale(35))];
    NSMutableAttributedString *rankStr = [[NSMutableAttributedString alloc] initWithString:@"第3名"];
    [rankStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(1, [rankStr length] - 2)];
    [rankStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:WidthScale(17)] range:NSMakeRange(0, rankStr.length)];
    rankLabel.attributedText = rankStr;
    rankLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"闲置二手交易";
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:WidthScale(20)]};
    CGSize size=[nameLabel.text sizeWithAttributes:attrs];
    nameLabel.frame = CGRectMake((step1View.frame.size.width - size.width - WidthScale(30)) / 2, CGRectGetMaxY(rankLabel.frame) + HeightScale(5), size.width + WidthScale(30), HeightScale(40));
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:WidthScale(20)];
    nameLabel.textColor = [UIColor redColor];
    nameLabel.layer.cornerRadius = WidthScale(5);
    
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = [UIColor redColor].CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRoundedRect:nameLabel.bounds cornerRadius:WidthScale(5)].CGPath;
    
    border.frame = nameLabel.bounds;
    
    border.lineWidth = 1.f;
    
    border.lineCap = @"round";
    border.cornerRadius = WidthScale(5);
    
    border.lineDashPattern = @[@4, @2];
    
    [nameLabel.layer addSublayer:border];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame), step1View.frame.size.width, HeightScale(40))];
    tipLabel.text = @"长按复制关键词";
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
    [step1View addSubview:tipLabel];
    [step1View addSubview:nameLabel];
    [step1View addSubview:rankLabel];
    [step1View addSubview:imageView];
    [step1View addSubview:step1ImageView];
    [scrollView addSubview:step1View];
    
    
    
    
    
    
    
    
    
    UIView *step2View = [[UIView alloc] initWithFrame:CGRectMake(WidthScale(15), CGRectGetMaxY(step1View.frame) + HeightScale(20), SWIDTH - WidthScale(30), SWIDTH / 1.7)];
    step2View.backgroundColor = [UIColor whiteColor];
    step2View.layer.cornerRadius = WidthScale(8);
    
    UIImageView *step2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(-2), HeightScale(15), WidthScale(67), HeightScale(30))];
    step2ImageView.image = [UIImage imageNamed:@"步骤二"];
    
    UIScrollView *advanceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HeightScale(80), step2View.frame.size.width, HeightScale(60))];
    advanceScrollView.backgroundColor = [UIColor lightGrayColor];
    
    for (int i = 0; i < 7; i++) {
        
    }
    
    [step2View addSubview:advanceScrollView];
    [step2View addSubview:step2ImageView];
    [scrollView addSubview:step2View];
    
    scrollView.contentSize = CGSizeMake(SWIDTH, CGRectGetMaxY(step2View.frame) + HeightScale(30));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
