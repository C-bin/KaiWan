//
//  TaskStepCommit.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TaskStepCommit.h"

static CGFloat sampleImageViewWidth;

@interface TaskStepCommit ()

@property (nonatomic, strong) UILabel * noticeLabel;

@end

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
        
        
        self.commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.commitButton setTitle:@"提交审核" forState:UIControlStateNormal];
        [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.commitButton.layer.cornerRadius = WidthScale(5);
        
        
        self.noticeLabel = [[UILabel alloc] init];
        self.noticeLabel.text = @"* 请严格按照规则提交截图，如有问题，请联系官方客服解决。";
        self.noticeLabel.font = [UIFont systemFontOfSize:WidthScale(13)];
        self.noticeLabel.adjustsFontSizeToFitWidth = YES;
        self.noticeLabel.textColor = [UIColor redColor];
        
        [self addSubview:self.noticeLabel];
        [self addSubview:self.commitButton];
    
    }
    return self;
}

- (void)setSampleImgArr:(NSArray *)sampleImgArr{
    _sampleImgArr = sampleImgArr;
    
    
    _tapGestureArr = [NSMutableArray array];
    
    sampleImageViewWidth = (self.frame.size.width - WidthScale(20)) / 2;
    for (int i = 0; i < _sampleImgArr.count * 2; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(5) + i % 2 * (sampleImageViewWidth + WidthScale(10)), HeightScale(50) + i / 2 * (sampleImageViewWidth * 1.5 + HeightScale(10)), sampleImageViewWidth, sampleImageViewWidth * 1.5)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 10 + i;
        
        if (imageView.tag % 2) {
            imageView.image = [UIImage imageNamed:@"点此上传"];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
            [imageView addGestureRecognizer:tap];
            [_tapGestureArr addObject:tap];
        } else {
            [imageView sd_setImageWithURL:[NSURL URLWithString:_sampleImgArr[i / 2]]];
        }
        
        [self addSubview:imageView];
        
    }
    
    self.commitButton.frame = CGRectMake(WidthScale(10), HeightScale(50) + (sampleImageViewWidth * 1.5 + HeightScale(10)) * sampleImgArr.count, self.frame.size.width - WidthScale(20), HeightScale(36));
    
    self.noticeLabel.frame = CGRectMake(WidthScale(10), CGRectGetMaxY(self.commitButton.frame), self.frame.size.width - WidthScale(20), HeightScale(30));
}


@end
