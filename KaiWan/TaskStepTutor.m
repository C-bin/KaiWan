//
//  TaskStepTutor.m
//  KaiWan
//
//  Created by van7ish on 2017/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "TaskStepTutor.h"
#import "XWScanImage.h"

static CGFloat tutorImageViewWidth;

@interface TaskStepTutor ()

@property (nonatomic, strong) UIView * background;

@property (nonatomic, strong) UILabel * noticeLabel;

@end
@implementation TaskStepTutor

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = WidthScale(8);
        UIImageView *step1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(-2), HeightScale(15), WidthScale(67), HeightScale(30))];
        step1ImageView.image = [UIImage imageNamed:@"步骤一"];
        

        
        self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.startButton setTitle:@"开始任务" forState:UIControlStateNormal];
        self.startButton.titleLabel.font = [UIFont systemFontOfSize:WidthScale(18)];
        [self.startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.startButton setBackgroundColor:BGColorForButton];
        self.startButton.layer.cornerRadius = WidthScale(5);
    
        
        self.noticeLabel = [[UILabel alloc] init];
        self.noticeLabel.text = @"* 可点击图片查看任务教程。";
        self.noticeLabel.textColor = ColorForNotice;
        self.noticeLabel.font = [UIFont systemFontOfSize:WidthScale(13)];
        
        [self addSubview:self.noticeLabel];
        [self addSubview:self.startButton];
        [self addSubview:step1ImageView];
    }
    return self;
}

- (void)setTutorImgArr:(NSArray *)tutorImgArr{
    _tutorImgArr = tutorImgArr;
    
    tutorImageViewWidth = (self.frame.size.width - WidthScale(30)) / 3;
    for (int i = 0; i < _tutorImgArr.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WidthScale(5) + i % 3 * (tutorImageViewWidth + WidthScale(10)), HeightScale(60) + i / 3 * (tutorImageViewWidth + WidthScale(10)), tutorImageViewWidth, tutorImageViewWidth)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_tutorImgArr[i]]];
        imageView.tag = 10 + i;
        imageView.userInteractionEnabled = YES;
        imageView.layer.cornerRadius = WidthScale(5);
        imageView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [imageView addGestureRecognizer:tap];
        
        [self addSubview:imageView];
    }
    
    self.startButton.frame = CGRectMake(WidthScale(10), HeightScale(70) + (tutorImageViewWidth + HeightScale(10)) * (_tutorImgArr.count / 3 + ((_tutorImgArr.count % 3) ? 1 : 0)), self.frame.size.width - WidthScale(20), HeightScale(36));
    
    self.noticeLabel.frame = CGRectMake(WidthScale(10), CGRectGetMaxY(self.startButton.frame), self.frame.size.width - WidthScale(20), HeightScale(30));

}

- (void)tap:(UITapGestureRecognizer *)tap{
    DLog(@"tag = %ld", tap.view.tag);
    
    UIImageView *imageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:imageView];
    
}

@end
