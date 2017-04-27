//
//  TaskInfoView.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TaskInfoView.h"

@interface TaskInfoView ()

@property (nonatomic, strong) UIView * stepView;
@property (nonatomic, strong) UIView * infoView;

@end
@implementation TaskInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, HeightScale(80))];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(12), HeightScale(15), WidthScale(50), WidthScale(50))];
        self.iconImageView.layer.cornerRadius = WidthScale(8);
        self.iconImageView.layer.masksToBounds = YES;
        
        [self addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + WidthScale(10), self.iconImageView.frame.origin.y + HeightScale(6), WidthScale(200), HeightScale(18))];
        self.titleLabel.font = [UIFont systemFontOfSize:WidthScale(16)];
        [self addSubview:self.titleLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.titleLabel.frame) + HeightScale(5), WidthScale(200), HeightScale(16))];
        self.timeLabel.font = [UIFont systemFontOfSize:WidthScale(13)];
        [self addSubview:self.timeLabel];
        
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width - WidthScale(108), HeightScale(20), WidthScale(100), HeightScale(40))];
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
        self.moneyLabel.textColor = [UIColor redColor];
        self.moneyLabel.font = [UIFont systemFontOfSize:WidthScale(20)];
        [self addSubview:self.moneyLabel];
        
        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(WidthScale(10), self.infoView.frame.size.height - HeightScale(1), SWIDTH - WidthScale(20), HeightScale(1))];
        underLine.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        
        [self addSubview:underLine];
        
        self.stepView = [[UIView alloc] init];
        self.stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthScale(15), HeightScale(15), SWIDTH - WidthScale(20), HeightScale(200))];
        
        [self addSubview:self.stepView];
        
        [self.stepView addSubview:self.stepLabel];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImageUrl, dataDic[@"img"]]] placeholderImage:[UIImage imageNamed:@"列表-问号"]];
    
    self.titleLabel.text = dataDic[@"keywords"] ? : dataDic[@"name"];
    
    if ([dataDic[@"reward"] containsString:@","]) {
        //深度任务
        float sumReward = 0;
        NSArray *rewardArr = [dataDic[@"reward"] componentsSeparatedByString:@","];
        for (int i = 0; i < rewardArr.count; i++) {
            sumReward += [rewardArr[i] floatValue];
        }
        
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"+" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(15)], NSForegroundColorAttributeName:COLOR_RGB(219, 3, 3, 1)}];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", sumReward] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(24)], NSForegroundColorAttributeName:COLOR_RGB(219, 3, 3, 1)}];
        NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:@"元" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(12)], NSForegroundColorAttributeName:COLOR_RGB(219, 3, 3, 1)}];
        [str1 appendAttributedString:str2];
        [str1 appendAttributedString:str3];
        
        self.moneyLabel.attributedText = str1;
    } else {
        //非深度任务
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"+" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(15)], NSForegroundColorAttributeName:COLOR_RGB(219, 3, 3, 1)}];
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", [dataDic[@"reward"] floatValue]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(24)], NSForegroundColorAttributeName:COLOR_RGB(219, 3, 3, 1)}];
        NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:@"元" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(12)], NSForegroundColorAttributeName:COLOR_RGB(219, 3, 3, 1)}];
        [str1 appendAttributedString:str2];
        [str1 appendAttributedString:str3];
        
        self.moneyLabel.attributedText = str1;
    }
    
    
    //参与步骤
    NSMutableString *str = [NSMutableString stringWithFormat:@"参与步骤:\n1.复制下方关键字，在App Store搜索下载，找到下面对应图标，约在第%@名下载", self.dataDic[@"location"]];
    NSMutableArray *tempArr = [NSMutableArray array];
    if ([dataDic[@"title"] length]) {
        [tempArr addObject:dataDic[@"title"]];
    }
    if ([dataDic[@"description"] length]) {
        [tempArr addObject:dataDic[@"description"]];
    }
    if ([dataDic[@"content"] length]) {
        [tempArr addObject:dataDic[@"content"]];
    }
    
    [tempArr addObject:@"返回本页提交任务，领取奖励"];
    
    for (int i = 0; i < tempArr.count; i ++) {
        [str appendFormat:@"\n%d.%@", i + 2 ,tempArr[i]];
    }
    
    
    // 创建 NSMutableAttributedString
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    // 设置字体和设置字体的范围
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(16)],
                             NSForegroundColorAttributeName:COLOR_RGB(50, 50, 50, 1)
                             }
                    range:NSMakeRange(0, 5)];
    
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(15)],
                             NSForegroundColorAttributeName:COLOR_RGB(102, 102, 102, 1)
                             }
                             range:NSMakeRange(5, [str length] - 5)];
    // 添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]
                    range:NSMakeRange(43, [[NSString stringWithFormat:@"%@", dataDic[@"location"]] length])];
    
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:HeightScale(14)];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
    
    // 自动换行
    self.stepLabel.numberOfLines = 0;
    // 设置label的富文本
    self.stepLabel.attributedText = attrStr;
    // label高度自适应
    [self.stepLabel sizeToFit];
    
    self.stepView.frame = CGRectMake(0, CGRectGetMaxY(self.infoView.frame), SWIDTH, self.stepLabel.frame.size.height + HeightScale(40));
    
    self.frame = CGRectMake(0, 0, SWIDTH, self.stepView.frame.size.height + self.infoView.frame.size.height);
    
}


@end
