//
//  WithdrawTableViewCell.m
//  KaiWan
//
//  Created by chenguang on 17/4/5.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "WithdrawTableViewCell.h"

@implementation WithdrawTableViewCell
{
    UIImageView *icon;
    UILabel *titlelabel;
    UILabel *timelabel;
    UILabel *moneyLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
        
    }
    return self;
}
- (void)setUI {
    icon = [[UIImageView alloc]init];
    [self.contentView addSubview:icon];
    [icon makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.centerY);
        make.left.equalTo([UIView setWidth:12]);
        make.width.height.equalTo([UIView setHeight:40]);
        
    }];
    
    titlelabel = [[UILabel alloc]init];
    titlelabel.textColor = [UIColor blackColor];
    titlelabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:titlelabel];
    [titlelabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.right).offset([UIView setWidth:15]);
        make.bottom.equalTo(self.contentView.centerY).offset(-[UIView setHeight:4]);
        
    }];
    timelabel = [[UILabel alloc]init];
    timelabel.textColor = SF_COLOR(197, 197, 197);
    timelabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:timelabel];
    [timelabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titlelabel.left);
        make.top.equalTo(titlelabel.bottom).offset([UIView setHeight:8]);
    }];
    moneyLabel = [[UILabel alloc]init];
    moneyLabel.textColor = SF_COLOR(219, 3, 3);
    moneyLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:moneyLabel];
    [moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(-[UIView setHeight:12]);
    }];

}
- (void)reloadWithModel:(WIthDrawModel *)model {
    moneyLabel.text = [NSString stringWithFormat:@"-%@元",model.money];
    timelabel.text = @"2017.1.12";
    if (model.tid.integerValue==1) {
        titlelabel.text = @"支付宝提现";
        icon.image = [UIImage imageNamed:@"支付宝支付"];
    }else {
        titlelabel.text = @"微信提现";
        icon.image = [UIImage imageNamed:@"微信支付"];

    }
    
    timelabel.text = model.time;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
