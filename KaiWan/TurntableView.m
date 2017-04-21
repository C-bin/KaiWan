//
//  TurntableView.m
//  YDXTurntable
//
//  Created by LIN on 16/11/26.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "TurntableView.h"
#import "Masonry.h"
#import "myUILabel.h"
#define turnScale_W self.bounds.size.width/300
#define turnScale_H self.bounds.size.height/300
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@implementation TurntableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)setNumberArray:(NSArray *)numberArray {
    _numberArray = numberArray;
    for (int i = 0; i < _numberArray.count; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:550+i];
        label.text = _numberArray[i];
    }
}
-(void)initUI
{
    
    self.rotateWheel = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:self.rotateWheel];
    self.rotateWheel.image = [UIImage imageNamed:@"内转盘"];
    
    
    self.playButton = [[UIButton alloc]initWithFrame:
                       CGRectMake(0,
                                  0,
                                  CGRectGetWidth(self.bounds)/3,
                                  CGRectGetHeight(self.bounds)/3)];
    self.playButton.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetWidth(self.bounds)/2);
    self.playButton.layer.cornerRadius = CGRectGetWidth(self.bounds)/3/2;
//    self.playButton.backgroundColor = [UIColor whiteColor];
    
    UIImageView * backImageView = [UIImageView new];
    backImageView.image = [UIImage imageNamed:@"go"];
    [self addSubview:backImageView];
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rotateWheel.mas_centerX).with.offset(0);
        make.centerY.mas_equalTo(self.rotateWheel.mas_centerY).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(WidthScale(268), WidthScale(268)));
    }];
    
    
    _numberArray = @[@"0.02元",@"0.16元",@"0.04元",@"0.08元",@"0.02元",@"0.16元",@"0.04元",@"0.08元"];
    
    for (int i = 0; i < 8; i ++) {
        myUILabel *label = [[myUILabel alloc]initWithFrame:CGRectMake(0, 0,M_PI * CGRectGetHeight(self.bounds)/8,
                                                                  CGRectGetHeight(self.bounds)/2)];
        label.layer.anchorPoint = CGPointMake(0.5, 1);
        label.center = CGPointMake(CGRectGetHeight(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        label.verticalAlignment = 0;

        CGFloat angle = M_PI * 2 / 8 * i+M_PI /8;

        label.font = [UIFont systemFontOfSize:14];
        label.transform = CGAffineTransformMakeRotation(angle);
        [self.rotateWheel addSubview:label];
        label.textColor = [UIColor whiteColor];

        label.tag = 550+i;
        
    }    [self addSubview:self.playButton];

}


@end
