//
//  TaskStepCommit.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TaskStepCommit.h"

@implementation TaskStepCommit

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = WidthScale(8);
        UIImageView *step1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(-2), HeightScale(15), WidthScale(67), HeightScale(30))];
        step1ImageView.image = [UIImage imageNamed:@"步骤二"];
        
        [self addSubview:step1ImageView];
        
        
        CGFloat imgW = (self.frame.size.width - WidthScale(20)) / 2;
        for (int i = 0; i < 4; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(5) + i % 2 * (imgW + WidthScale(10)), HeightScale(50) + i / 2 * (imgW * 1.5 + HeightScale(10)), imgW, imgW * 1.5)];
            imageView.image = [UIImage imageNamed:@"点此上传"];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 10 + i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [imageView addGestureRecognizer:tap];
            
            [self addSubview:imageView];
            
        }
        
        UIButton *commitButton = [[UIButton alloc] initWithFrame:CGRectMake(WidthScale(10), HeightScale(50) + imgW * 1.5 * 2 + HeightScale(30), self.frame.size.width - WidthScale(20), HeightScale(36))];
        [commitButton setTitle:@"提交审核" forState:UIControlStateNormal];
        [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [commitButton setBackgroundColor:COLOR_RGB(24, 82, 222, 1)];
        commitButton.layer.cornerRadius = WidthScale(5);
        [commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthScale(10), CGRectGetMaxY(commitButton.frame), self.frame.size.width - WidthScale(20), HeightScale(30))];
        noticeLabel.text = @"* 请严格按照规则提交截图，如有问题，请联系官方客服解决。";
        noticeLabel.font = [UIFont systemFontOfSize:WidthScale(13)];
        noticeLabel.adjustsFontSizeToFitWidth = YES;
        noticeLabel.textColor = [UIColor redColor];
        
        [self addSubview:noticeLabel]; 
        [self addSubview:commitButton];
        
        
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap{
    DLog(@"tag = %ld", tap.view.tag);
}

- (void)commitButtonClicked:(UIButton *)button{
    DLog(@"提交审核");
}

@end
