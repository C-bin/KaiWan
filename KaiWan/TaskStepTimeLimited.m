//
//  TaskStepTimeLimited.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TaskStepTimeLimited.h"

@implementation TaskStepTimeLimited

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = WidthScale(8);
        
        UIImageView *step2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(-2), HeightScale(15), WidthScale(67), HeightScale(30))];
        step2ImageView.image = [UIImage imageNamed:@"步骤二"];
        
        self.receiveButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - WidthScale(150)) / 2, HeightScale(50), WidthScale(150), HeightScale(36))];
        [self.receiveButton setTitle:@"领取奖励" forState:UIControlStateNormal];
        [self.receiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.receiveButton setBackgroundColor:[UIColor grayColor]];
        self.receiveButton.layer.cornerRadius = WidthScale(5);
        
        self.leftTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.receiveButton.frame), self.frame.size.width, HeightScale(30))];
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"试玩3分钟 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(13)], NSForegroundColorAttributeName:[UIColor colorWithWhite:0.8 alpha:1]}];
        
        NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"3:00" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(13)], NSForegroundColorAttributeName:[UIColor redColor]}];
        
        [str1 appendAttributedString:str2];
        self.leftTimeLabel.textAlignment = NSTextAlignmentCenter;
        self.leftTimeLabel.attributedText = str1;
        
        [self addSubview:step2ImageView];
        [self addSubview:self.receiveButton];
        [self addSubview:self.leftTimeLabel];
        
    }
    return self;
}


@end
