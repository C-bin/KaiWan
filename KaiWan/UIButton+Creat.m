//
//  UIButton+Creat.m
//  KaiWan
//
//  Created by chenguang on 17/4/7.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "UIButton+Creat.h"

@implementation UIButton (Creat)
+ (UIButton *)creatButtonWithTitle:(NSString *)title andBgColor:(UIColor *)bgcolor andTextColor:(UIColor *)textColor andtitleFont:(NSInteger )font {
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    if (bgcolor) {
        btn.backgroundColor = bgcolor;
    }if (textColor) {
        [btn setTitleColor:textColor forState:UIControlStateNormal];
    }if (font>0) {
        btn.titleLabel.font = [UIFont systemFontOfSize:font];
    }
    return btn;
}
@end
