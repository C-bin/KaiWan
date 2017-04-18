//
//  TaskStepCopy.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TaskStepCopy.h"

@implementation TaskStepCopy

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = WidthScale(8);
        UIImageView *step1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(-2), HeightScale(15), WidthScale(67), HeightScale(30))];
        step1ImageView.image = [UIImage imageNamed:@"步骤一"];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - WidthScale(70)) / 2, HeightScale(30), WidthScale(70), HeightScale(70))];
        
        self.rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame), self.frame.size.width, HeightScale(35))];
        self.rankLabel.textAlignment = NSTextAlignmentCenter;
        
        self.nameLabel = [[UILabel alloc] init];

        
        self.longPress = [[UILongPressGestureRecognizer alloc] init];
        self.longPress.minimumPressDuration = 1;
        [self.nameLabel addGestureRecognizer:self.longPress];
        self.nameLabel.userInteractionEnabled = YES;
        
    
        [self addSubview:self.nameLabel];
        [self addSubview:self.rankLabel];
        [self addSubview:self.iconImageView];
        [self addSubview:step1ImageView];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImageUrl, dataDic[@"img"]]] placeholderImage:[UIImage imageNamed:@"列表-问号"]];
    
    NSMutableAttributedString *rankStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"第%d名", [dataDic[@"location"] intValue]]];
    [rankStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(1, [rankStr length] - 2)];
    [rankStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:WidthScale(17)] range:NSMakeRange(0, rankStr.length)];
    self.rankLabel.attributedText = rankStr;
    
    self.nameLabel.text = dataDic[@"keywords"];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:WidthScale(20)]};
    CGSize size=[self.nameLabel.text sizeWithAttributes:attrs];
    self.nameLabel.frame = CGRectMake((self.frame.size.width - size.width - WidthScale(30)) / 2, CGRectGetMaxY(self.rankLabel.frame) + HeightScale(5), size.width + WidthScale(30), HeightScale(30));
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:WidthScale(18)];
    self.nameLabel.textColor = [UIColor redColor];
    self.nameLabel.layer.cornerRadius = WidthScale(5);
    
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = [UIColor redColor].CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRoundedRect:self.nameLabel.bounds cornerRadius:WidthScale(5)].CGPath;
    
    border.frame = self.nameLabel.bounds;
    
    border.lineWidth = 1.f;
    
    border.lineCap = @"round";
    border.cornerRadius = WidthScale(5);
    
    border.lineDashPattern = @[@4, @2];
    
    [self.nameLabel.layer addSublayer:border];
    
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame), self.frame.size.width, HeightScale(35))];
    tipLabel.text = @"长按复制关键词";
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:tipLabel];

}

@end
