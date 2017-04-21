//
//  TaskStepDeep.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TaskStepDeep.h"
#import "DeepTaskModel.h"

@interface TaskStepDeep ()

@property (nonatomic, strong) UIScrollView * advanceScrollView;

@end

@implementation TaskStepDeep

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = WidthScale(8);
        
        UIImageView *step2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(-2), HeightScale(15), WidthScale(67), HeightScale(30))];
        step2ImageView.image = [UIImage imageNamed:@"步骤二"];
        
        
        self.advanceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HeightScale(70), self.frame.size.width, HeightScale(55))];
        
        
        self.receiveButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - WidthScale(150)) / 2, CGRectGetMaxY(self.advanceScrollView.frame) + HeightScale(10), WidthScale(150), HeightScale(36))];
        [self.receiveButton setTitle:@"领取奖励" forState:UIControlStateNormal];
        [self.receiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.receiveButton.titleLabel setFont:[UIFont systemFontOfSize:WidthScale(18)]];
        self.receiveButton.layer.cornerRadius = WidthScale(5);
        
        
        self.leftTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.receiveButton.frame), self.frame.size.width, HeightScale(30))];
        
        self.advanceScrollView.showsHorizontalScrollIndicator = NO;
        self.advanceScrollView.bounces = NO;
        
        
        [self addSubview:self.leftTimeLabel];
        [self addSubview:self.receiveButton];
        [self addSubview:self.advanceScrollView];
        [self addSubview:step2ImageView];
        

    }
    return self;
}

- (void)setDeepTaskModel:(DeepTaskModel *)deepTaskModel{
    _deepTaskModel = deepTaskModel;
    
    NSArray *rewardArr = [deepTaskModel.reward componentsSeparatedByString:@","];
    
    for (int i = 0; i < rewardArr.count; i++) {
        

        UIImageView *dayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(5) + i * WidthScale(50), 0, WidthScale(35), HeightScale(35))];
        
        UILabel *cashLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, WidthScale(30), HeightScale(35))];
        
        if (i < [deepTaskModel.days intValue]) {
            dayImageView.image = [UIImage imageNamed:@"已领"];
            cashLabel.textColor = [UIColor whiteColor];
        } else {
            dayImageView.layer.cornerRadius = WidthScale(35 / 2);
            dayImageView.layer.borderWidth = WidthScale(0.5);
            dayImageView.layer.borderColor = [UIColor redColor].CGColor;
            
            cashLabel.textColor = [UIColor redColor];
        }
        
        [self.advanceScrollView addSubview:dayImageView];
        
        
        cashLabel.text = [NSString stringWithFormat:@"+%.2f", [rewardArr[i] floatValue]];
        cashLabel.textAlignment = NSTextAlignmentCenter;
        cashLabel.font = [UIFont systemFontOfSize:12];
        cashLabel.adjustsFontSizeToFitWidth = YES;
        [dayImageView addSubview:cashLabel];
        
        if (i < rewardArr.count - 1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dayImageView.frame), HeightScale(17.5), WidthScale(15), HeightScale(0.5))];
            lineView.backgroundColor = [UIColor redColor];
            [self.advanceScrollView addSubview:lineView];
        }
        
        
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(dayImageView.frame.origin.x, CGRectGetMaxY(dayImageView.frame), WidthScale(35), HeightScale(20))];
        dayLabel.text = [NSString stringWithFormat:@"第%d天", i + 1];
        dayLabel.font = [UIFont systemFontOfSize:12.5];
        dayLabel.adjustsFontSizeToFitWidth = YES;
        dayLabel.textColor = [UIColor grayColor];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.advanceScrollView addSubview:dayLabel];
    }
    self.advanceScrollView.contentSize = CGSizeMake(WidthScale(-5) + 7 * WidthScale(50), HeightScale(55));
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"试玩3分钟 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(13)], NSForegroundColorAttributeName:[UIColor colorWithWhite:0.7 alpha:1]}];
    
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"03:00" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WidthScale(13)], NSForegroundColorAttributeName:[UIColor redColor]}];

    
    
    [str1 appendAttributedString:str2];
    self.leftTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.leftTimeLabel.attributedText = str1;

    
}

@end
