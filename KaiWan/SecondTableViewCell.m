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
    UIImageView *NoneImage;
    UILabel *timeLabel;
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
    
    titlelabel.font = [UIFont systemFontOfSize:18];
    titlelabel.textColor = [UIColor blackColor];
    [bgimage addSubview:titlelabel];
    
    [titlelabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconimage.right).offset([UIView setWidth:15]);
        make.top.equalTo(bgimage.top).offset([UIView setHeight:18]);
    }];
    
    cateLabel = [[UILabel alloc]init];
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

    [bgimage addSubview:priceLabel];
    priceLabel.textAlignment = NSTextAlignmentRight;

    [priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgimage.right).offset(-[UIView setWidth:10]);
        make.centerY.equalTo(bgimage);
    }];
    
    NoneImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"列表-已抢完"]];
    [bgimage addSubview:NoneImage];
    
    [NoneImage makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-WidthScale(108));
        make.centerY.equalTo(0);
        make.height.equalTo(HeightScale(48));
        make.width.equalTo(HeightScale(0));
    }];
    
    timeLabel = [[UILabel alloc]init];
    timeLabel.textColor = SF_COLOR(255, 86, 86);
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.layer.borderColor = SF_COLOR(255, 86, 86).CGColor;
    timeLabel.layer.borderWidth = 0.5;
    timeLabel.layer.cornerRadius = 2;
    timeLabel.clipsToBounds = YES;
    timeLabel.text = @"";
    [bgimage addSubview:timeLabel];
    
    [timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numLabel.right).offset([UIView setWidth:10]);
        make.top.and.height.equalTo(cateLabel);
        
    }];
}
- (void)reloadWithDic:(NSDictionary *)dic {
    //好评任务50,高额任务51,深度任务55,限时任务 7
    NSString *tid = [NSString creatWithId:dic[@"tid"]];
    
    switch (tid.integerValue) {
        case 50:
            titlelabel.text = [NSString creatWithId:dic[@"keywords"]];
            cateLabel.text = @" 好评 ";

            break;
        case 51:
            titlelabel.text = [NSString creatWithId:dic[@"name"]];
            cateLabel.text = @" 高额 ";

            break;
        case 55:
            titlelabel.text = [NSString creatWithId:dic[@"keywords"]];
            cateLabel.text = @" 深度 ";

            break;
        case 7:
            titlelabel.text = [NSString creatWithId:dic[@"name"]];
            cateLabel.text = @" 限时 ";

            break;
        case 58:
            titlelabel.text = [NSString creatWithId:dic[@"keywords"]];
            cateLabel.text = @"联盟";

        default:
            break;
    }
    [iconimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,dic[@"img"]]]];
    
    if ([NSString creatWithId:dic[@"amount"]].integerValue<1) {
        [NoneImage updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(HeightScale(48));
        }];
        
        numLabel.text = @" 剩余0份 ";

    }else {
        [NoneImage updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(HeightScale(0));
        }];
        
        numLabel.text = [NSString stringWithFormat:@" 剩余%@份 ",dic[@"amount"]];

    }
    
    //-98=无状态,0=点击（已领取），1 = 已完成 ，4 = 等待审核
    NSString *status = [NSString creatWithId:dic[@"status"]];


    switch (status.integerValue) {
        case -98:
        {    NSString *str = [NSString creatWithId:dic[@"reward"]];
            NSString *astr = [NSString stringWithFormat:@"+%@元",str];
            priceLabel.textColor = SF_COLOR(219, 3, 3);
            priceLabel.font = [UIFont systemFontOfSize:15];
            NSMutableAttributedString *mstr=[[NSMutableAttributedString alloc]initWithString:astr];
            [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
            [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(1, str.length)];
            [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(1+[str length], 1)];
            priceLabel.attributedText = mstr;

            break;}
        case 0:
        {priceLabel.font = [UIFont systemFontOfSize:24];
            priceLabel.textColor = SF_COLOR(28, 108, 229);
            priceLabel.text = @"进行中";
            
            break;}
        case 1:
        { priceLabel.font = [UIFont systemFontOfSize:24];
            priceLabel.textColor = SF_COLOR(0,0,0);
            priceLabel.text = @"已完成";
            
            break;}
        case 4:
        {priceLabel.font = [UIFont systemFontOfSize:24];
            priceLabel.textColor = SF_COLOR(28, 108, 229);
            priceLabel.text = @"等待审核";
            
            break;}
            
        default:
            
            break;
    }
    NSString *time = [NSString creatWithId:dic[@"time"]];
    if (time.length>0) {
        timeLabel.text = [NSString stringWithFormat:@" %@ ",time];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
