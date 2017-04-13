//
//  TaskStepDeep.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TaskStepDeep.h"

@implementation TaskStepDeep

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = WidthScale(8);
        
        UIImageView *step2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(-2), HeightScale(15), WidthScale(67), HeightScale(30))];
        step2ImageView.image = [UIImage imageNamed:@"步骤二"];
        
        
        UIScrollView *advanceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HeightScale(70), self.frame.size.width, HeightScale(55))];
        
        for (int i = 0; i < 7; i++) {
            UIImageView *dayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(5) + i * WidthScale(50), 0, WidthScale(35), HeightScale(35))];
            dayImageView.image = [UIImage imageNamed:@"已领"];
            [advanceScrollView addSubview:dayImageView];
            
            UILabel *cashLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, WidthScale(30), HeightScale(35))];
            cashLabel.text = @"+1.00";
            cashLabel.textAlignment = NSTextAlignmentCenter;
            cashLabel.textColor = [UIColor whiteColor];
            cashLabel.font = [UIFont systemFontOfSize:12];
            cashLabel.adjustsFontSizeToFitWidth = YES;
            [dayImageView addSubview:cashLabel];
            
            if (i < 6) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dayImageView.frame), HeightScale(19.5), WidthScale(15), HeightScale(0.5))];
                lineView.backgroundColor = [UIColor redColor];
                [advanceScrollView addSubview:lineView];
            }
            
            
            UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(dayImageView.frame.origin.x, CGRectGetMaxY(dayImageView.frame), WidthScale(35), HeightScale(20))];
            dayLabel.text = [NSString stringWithFormat:@"第%d天", i + 1];
            dayLabel.font = [UIFont systemFontOfSize:12.5];
            dayLabel.adjustsFontSizeToFitWidth = YES;
            dayLabel.textColor = [UIColor grayColor];
            dayLabel.textAlignment = NSTextAlignmentCenter;
            
            [advanceScrollView addSubview:dayLabel];
        }
        
        
        UIButton *receiveButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - WidthScale(150)) / 2, CGRectGetMaxY(advanceScrollView.frame) + HeightScale(10), WidthScale(150), HeightScale(36))];
        [receiveButton setTitle:@"领取奖励" forState:UIControlStateNormal];
        [receiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [receiveButton.titleLabel setFont:[UIFont systemFontOfSize:WidthScale(18)]];
        [receiveButton setBackgroundColor:COLOR_RGB(24, 82, 222, 1)];
        receiveButton.layer.cornerRadius = WidthScale(5);
        [receiveButton addTarget:self action:@selector(receiveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *leftTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(receiveButton.frame), self.frame.size.width, HeightScale(30))];
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"试玩3分钟 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(13)], NSForegroundColorAttributeName:[UIColor colorWithWhite:0.8 alpha:1]}];
        
        NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"00:32" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(13)], NSForegroundColorAttributeName:[UIColor redColor]}];
        
        [str1 appendAttributedString:str2];
        leftTimeLabel.textAlignment = NSTextAlignmentCenter;
        leftTimeLabel.attributedText = str1;
        
        advanceScrollView.contentSize = CGSizeMake(WidthScale(-5) + 7 * WidthScale(50), HeightScale(55));
        advanceScrollView.showsHorizontalScrollIndicator = NO;
        advanceScrollView.bounces = NO;
        
        
        [self addSubview:leftTimeLabel];
        [self addSubview:receiveButton];
        [self addSubview:advanceScrollView];
        [self addSubview:step2ImageView];
        

    }
    return self;
}

- (void)receiveButtonClicked:(UIButton *)button{
    DLog(@"领取奖励");
}

@end
