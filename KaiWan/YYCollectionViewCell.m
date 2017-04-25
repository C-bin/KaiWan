//
//  YYCollectionViewCell.m
//  KaiWan
//
//  Created by chenguang on 17/3/3.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "YYCollectionViewCell.h"

@implementation YYCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, [UIView setHeight:122])];
        [self.contentView addSubview:img];
        self.imageView = img;
    }
    
    return self;
}
- (void)setImge:(UIImage *)imge {
    _imge = imge;
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imge] placeholderImage:[UIImage imageNamed:@"占位图"]];
    self.imageView.image = imge;
}

@end
