//
//  UILabel+Creat.m
//  KaiWan
//
//  Created by chenguang on 17/4/7.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "UILabel+Creat.h"

@implementation UILabel (Creat)
+(UILabel *)creatLabelWithFont:(NSInteger)font andbgcolor:(UIColor *)bgcolor andtextColor:(UIColor *)textColor andAligment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc]init];
    if (font) {
        label.font = [UIFont systemFontOfSize:font];
    }
    if (bgcolor) {
        label.backgroundColor = bgcolor;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    if (alignment) {
        label.textAlignment = alignment;
    }
    return label;
}
@end
