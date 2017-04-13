//
//  TaskStepTutor.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TaskStepTutor.h"

@implementation TaskStepTutor

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = WidthScale(8);
        UIImageView *step1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(-2), HeightScale(15), WidthScale(67), HeightScale(30))];
        step1ImageView.image = [UIImage imageNamed:@"步骤一"];
        
        CGFloat imgW = (self.frame.size.width - WidthScale(30)) / 3;
        for (int i = 0; i < 6; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(5) + i % 3 * (imgW + WidthScale(10)), HeightScale(50) + i / 3 * (imgW + WidthScale(10)), imgW, imgW)];
            imageView.image = [UIImage imageNamed:@"教程"];
            imageView.tag = 10 + i;
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            
            [imageView addGestureRecognizer:tap];
            
            [self addSubview:imageView];
        }
        
        UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(WidthScale(10), HeightScale(75) + imgW * 2, self.frame.size.width - WidthScale(20), HeightScale(36))];
        [startButton setTitle:@"开始任务" forState:UIControlStateNormal];
        startButton.titleLabel.font = [UIFont systemFontOfSize:WidthScale(18)];
        [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [startButton setBackgroundColor:COLOR_RGB(24, 82, 222, 1)];
        startButton.layer.cornerRadius = WidthScale(5);
        [startButton addTarget:self action:@selector(startButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthScale(10), CGRectGetMaxY(startButton.frame), self.frame.size.width - WidthScale(20), HeightScale(30))];
        noticeLabel.text = @"* 可点击图片查看任务教程。";
        noticeLabel.textColor = [UIColor redColor];
        noticeLabel.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:noticeLabel];
        [self addSubview:startButton];
        [self addSubview:step1ImageView];
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap{
    DLog(@"tag = %ld", tap.view.tag);
    switch (tap.view.tag) {
        case 10:
            
            break;
            
        default:
            break;
    }
}

- (void)startButtonClicked:(UIButton *)button{
    DLog(@"开始任务");
}

@end
