//
//  SecondTableViewCell.m
//  KaiWan
//
//  Created by chenguang on 17/3/8.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell
{
    UIImageView *iconimage;
    UILabel *titlelabel;
    UILabel *cateLabel;
    UILabel *numLabel;
    UILabel *priceLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void) setUp {
    self.contentView.backgroundColor = SF_COLOR(235, 235, 235);

    UIImageView *bgimage = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:0 andWidth:375-24 andHeight:75]];
    bgimage.image =[UIImage imageNamed:@"列表-背景"];
    [self.contentView addSubview:bgimage];
    iconimage = [[UIImageView alloc]init];
    iconimage.layer.borderColor = SF_COLOR(229, 229, 229).CGColor;
    iconimage.layer.borderWidth = 0.5;
    iconimage.clipsToBounds = YES;
    iconimage.layer.cornerRadius = 5;
    iconimage.image = [UIImage imageNamed:@"列表-邀请好友"];
    [bgimage addSubview:iconimage];
    [iconimage makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgimage.centerY);
        make.height.and.width.equalTo([UIView setHeight:45]);
        make.left.equalTo(bgimage.left).offset([UIView setWidth:10]);
    }];
    
    titlelabel = [[UILabel alloc]init];
    titlelabel.text = @"大众点评";
    titlelabel.font = [UIFont systemFontOfSize:18];
    titlelabel.textColor = [UIColor blackColor];
    [bgimage addSubview:titlelabel];
    
    [titlelabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconimage.right).offset([UIView setWidth:15]);
        make.top.equalTo(bgimage.top).offset([UIView setHeight:18]);
    }];
    
    cateLabel = [[UILabel alloc]init];
    cateLabel.text = @" 限时 ";
    cateLabel.textColor = SF_COLOR(255, 86, 86);
    cateLabel.font = [UIFont systemFontOfSize:11];
    cateLabel.layer.borderColor = SF_COLOR(255, 86, 86).CGColor;
    cateLabel.layer.borderWidth = 0.5;
    cateLabel.layer.cornerRadius = 2;
    cateLabel.clipsToBounds = YES;
    [bgimage addSubview:cateLabel];
    [cateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titlelabel);
        make.top.equalTo(titlelabel.bottom).offset([UIView setHeight:8]);
        make.height.equalTo([UIView setHeight:13]);
    }];
    
    numLabel = [[UILabel alloc]init];
    numLabel.text = @" 剩余121份 ";
    numLabel.textColor = SF_COLOR(102, 102, 102);
    numLabel.font = [UIFont systemFontOfSize:11];
    numLabel.layer.borderColor = SF_COLOR(102, 102, 102).CGColor;
    numLabel.layer.borderWidth = 0.5;
    numLabel.layer.cornerRadius = 2;
    numLabel.clipsToBounds = YES;
    [bgimage addSubview:numLabel];
    
    [numLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cateLabel.right).offset([UIView setWidth:10]);
        make.top.and.height.equalTo(cateLabel);
        
    }];
    priceLabel = [[UILabel alloc]init];
    priceLabel.textColor = SF_COLOR(219, 3, 3);
    priceLabel.font = [UIFont systemFontOfSize:15];
    NSString *str = @"+1.00元";
    NSMutableAttributedString *mstr=[[NSMutableAttributedString alloc]initWithString:str];
    [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
    [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(1, 5)];
    [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(5, 1)];
    priceLabel.attributedText = mstr;
    [bgimage addSubview:priceLabel];
    priceLabel.textAlignment = NSTextAlignmentRight;
    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgimage.right).offset(-[UIView setWidth:10]);
        make.centerY.equalTo(bgimage);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
