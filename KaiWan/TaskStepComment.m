//
//  TaskStepComment.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TaskStepComment.h"

@implementation TaskStepComment

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = WidthScale(8);
        
        UIImageView *step2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(-2), HeightScale(15), WidthScale(67), HeightScale(30))];
        step2ImageView.image = [UIImage imageNamed:@"步骤二"];
        
        
        CGFloat imgW = (self.frame.size.width - WidthScale(30)) / 2;
        for (int i = 0; i < 2; i ++) {
            UIImageView *commImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(10) + i * (imgW +WidthScale(10)) , HeightScale(50), imgW, imgW * 1.6)];
            commImageView.tag = 10 + i;
            
            if (commImageView.tag == 10) {
                commImageView.image = [UIImage imageNamed:@"截图示例"];
            } else {
                commImageView.image = [UIImage imageNamed:@"点此上传"];
                commImageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
                [commImageView addGestureRecognizer:tap];
            }

            [self addSubview:commImageView];
        }
        
        UIButton *commitButton = [[UIButton alloc] initWithFrame:CGRectMake(WidthScale(10), HeightScale(50) + imgW * 1.6 + HeightScale(20), self.frame.size.width - WidthScale(20), HeightScale(36))];
        [commitButton setTitle:@"提交审核" forState:UIControlStateNormal];
        [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [commitButton setBackgroundColor:COLOR_RGB(24, 82, 222, 1)];
        commitButton.layer.cornerRadius = WidthScale(5);
        [commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthScale(10), CGRectGetMaxY(commitButton.frame), self.frame.size.width - WidthScale(30), HeightScale(30))];
        noticeLabel.text = @"* 请严格按照规则提交截图，如有问题，请联系官方客服解决。";
        noticeLabel.textColor = [UIColor redColor];
        noticeLabel.font = [UIFont systemFontOfSize:WidthScale(13)];
        noticeLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:noticeLabel];
        [self addSubview:commitButton];
        [self addSubview:step2ImageView];
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap{
    DLog(@"点此上传");
    
}

- (void)commitButtonClicked:(UIButton *)button{
    DLog(@"提交审核");
}



@end
