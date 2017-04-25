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
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(10), HeightScale(10), WidthScale(60), HeightScale(60))];
        [self addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + WidthScale(10), self.iconImageView.frame.origin.y, WidthScale(200), HeightScale(30))];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.titleLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.titleLabel.frame), WidthScale(200), HeightScale(30))];
        
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
    
    
    NSDictionary *firstDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:WidthScale(15)], NSFontAttributeName, [UIColor colorWithWhite:0.6 alpha:1], NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *firstStr = [[NSMutableAttributedString alloc] initWithString:@"任务剩余时间: " attributes:firstDic];
    NSDictionary *secondDic = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UIFont systemFontOfSize:WidthScale(15)], NSFontAttributeName,
                               [UIColor blueColor],NSForegroundColorAttributeName,nil];
    NSMutableAttributedString *secondStr;
    if (dataDic[@"extraTime"]) {
        secondStr = [[NSMutableAttributedString alloc] initWithString:[dataDic[@"extraTime"] stringValue] attributes:secondDic];
    } else {
        secondStr = [[NSMutableAttributedString alloc] initWithString:[dataDic[@"time"] stringValue] attributes:secondDic];
    }
    
    [firstStr appendAttributedString:secondStr];
    self.timeLabel.attributedText = firstStr;
    
    if ([dataDic[@"reward"] containsString:@","]) {
        NSUInteger sumReward = 0;
        NSArray *rewardArr = [dataDic[@"reward"] componentsSeparatedByString:@","];
        for (int i = 0; i < rewardArr.count; i++) {
            sumReward += [rewardArr[i] integerValue];
        }
        self.moneyLabel.text = [NSString stringWithFormat:@"+%ld元", (unsigned long)sumReward];
    } else {
        self.moneyLabel.text = [NSString stringWithFormat:@"+%@元", dataDic[@"reward"]];
    }
    
    
    NSString *str = [NSString stringWithFormat:@"参与步骤:\n1.复制下方关键字，在App Store搜索下载，找到下面对应图标，约在第%@名下载;\n2.%@;\n3.返回本页提交任务，领取奖励。", dataDic[@"location"], dataDic[@"description"] ? : dataDic[@"content"]];
    
    
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
                    range:NSMakeRange(43, [[NSString stringWithFormat:@"%@", dataDic[@"location"]] length])];
    //    [attrStr addAttribute:NSForegroundColorAttributeName
    //                    value:[UIColor redColor]
    //                    range:NSMakeRange(59, 5)];
    //    [attrStr addAttribute:NSForegroundColorAttributeName
    //                    value:[UIColor redColor]
    //                    range:NSMakeRange(68, 4)];
    
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
    
    // 自动换行
    self.stepLabel.numberOfLines = 0;
    // 设置label的富文本
    self.stepLabel.attributedText = attrStr;
    // label高度自适应
    [self.stepLabel sizeToFit];
    
    self.stepView.frame = CGRectMake(0, CGRectGetMaxY(self.infoView.frame), SWIDTH, self.stepLabel.frame.size.height + HeightScale(30));
    
    self.frame = CGRectMake(0, 0, SWIDTH, self.stepView.frame.size.height + self.infoView.frame.size.height);
    
}


@end
