//
//  TaskStepComment.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TaskStepComment.h"
#import "XWScanImage.h"

@implementation TaskStepComment

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = WidthScale(8);
        
        UIImageView *step2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(-2), HeightScale(20), WidthScale(67), HeightScale(30))];
        step2ImageView.image = [UIImage imageNamed:@"步骤二"];
        
        
        CGFloat imgW = (self.frame.size.width - WidthScale(30)) / 2;
        for (int i = 0; i < 2; i ++) {
            UIImageView *commImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(10) + i * (imgW +WidthScale(10)) , HeightScale(63), imgW, imgW * 1.6)];
            commImageView.tag = 10 + i;
            commImageView.userInteractionEnabled = YES;
            if (commImageView.tag == 10) {
                commImageView.image = [UIImage imageNamed:@"截图示例"];

                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
                [commImageView addGestureRecognizer:tap];
            } else {
                commImageView.image = [UIImage imageNamed:@"点此上传"];
                commImageView.userInteractionEnabled = YES;
                self.tap = [[UITapGestureRecognizer alloc] init];
                [commImageView addGestureRecognizer:self.tap];
            }

            [self addSubview:commImageView];
        }
        
        self.commitButton = [[UIButton alloc] initWithFrame:CGRectMake(WidthScale(10), HeightScale(50) + imgW * 1.6 + HeightScale(24), self.frame.size.width - WidthScale(20), HeightScale(37))];
        [self.commitButton setTitle:@"提交审核" forState:UIControlStateNormal];
        [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.commitButton setBackgroundColor:COLOR_RGB(24, 82, 222, 1)];
        self.commitButton.layer.cornerRadius = WidthScale(5);
        
        UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WidthScale(10), CGRectGetMaxY(self.commitButton.frame), self.frame.size.width - WidthScale(30), HeightScale(30))];
        noticeLabel.text = @"* 请严格按照规则提交截图，如有问题，请联系官方客服解决。";
        noticeLabel.textColor = ColorForNotice;
        noticeLabel.font = [UIFont systemFontOfSize:WidthScale(12)];
        noticeLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:noticeLabel];
        [self addSubview:self.commitButton];
        [self addSubview:step2ImageView];
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap{
    [XWScanImage scanBigImageWithImageView:(UIImageView *)tap.view];
}

@end
