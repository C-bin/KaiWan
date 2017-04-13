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
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - WidthScale(70)) / 2, HeightScale(30), WidthScale(70), HeightScale(70))];
        imageView.image = [UIImage imageNamed:@"列表-问号"];
        
        UILabel *rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), self.frame.size.width, HeightScale(35))];
        NSMutableAttributedString *rankStr = [[NSMutableAttributedString alloc] initWithString:@"第3名"];
        [rankStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(1, [rankStr length] - 2)];
        [rankStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:WidthScale(17)] range:NSMakeRange(0, rankStr.length)];
        rankLabel.attributedText = rankStr;
        rankLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = @"闲置二手交易";
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:WidthScale(20)]};
        CGSize size=[nameLabel.text sizeWithAttributes:attrs];
        nameLabel.frame = CGRectMake((self.frame.size.width - size.width - WidthScale(30)) / 2, CGRectGetMaxY(rankLabel.frame) + HeightScale(5), size.width + WidthScale(30), HeightScale(30));
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:WidthScale(18)];
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
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame), self.frame.size.width, HeightScale(35))];
        tipLabel.text = @"长按复制关键词";
        tipLabel.font = [UIFont systemFontOfSize:13];
        tipLabel.textColor = [UIColor lightGrayColor];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:tipLabel];
        [self addSubview:nameLabel];
        [self addSubview:rankLabel];
        [self addSubview:imageView];
        [self addSubview:step1ImageView];
    }
    return self;
}


@end
