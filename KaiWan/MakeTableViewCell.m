//
//  MakeTableViewCell.m
//  KaiWan
//
//  Created by chenguang on 17/4/5.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "MakeTableViewCell.h"

@implementation MakeTableViewCell


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
    
    self.icon = [[UIImageView alloc]init];
    self.icon.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.icon];
    [self.icon makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo([UIView setWidth:12]);
        make.width.and.height.equalTo([UIView setHeight:43]);
        
    }];
    
    
    self.typeLabel = [[UILabel alloc]init];
    self.typeLabel.font = [UIFont systemFontOfSize:16];
    self.typeLabel.textColor = SF_COLOR(0, 0, 0);
    [self.contentView addSubview:self.typeLabel];
    self.typeLabel.text = @"限时任务";
    [self.typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([UIView setHeight:14]);
        make.left.equalTo(self.icon.right).offset([UIView setWidth:10]);
        
    }];

    
    
    
    self.titlelabel = [[UILabel alloc]init];
    self.titlelabel.font = [UIFont systemFontOfSize:16];
    self.titlelabel.textColor = SF_COLOR(102, 102, 102);
    [self.contentView addSubview:self.titlelabel];
    self.titlelabel.text = @"二手交易";
    [self.titlelabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel);
        make.left.equalTo(self.typeLabel.right).offset([UIView setWidth:10]);
    }];

    
    self.timelabel = [[UILabel alloc]init];
    self.timelabel.font = [UIFont systemFontOfSize:12];
    self.timelabel.textColor = SF_COLOR(197, 197, 197);
    [self.contentView addSubview:self.timelabel];
      self.timelabel.text = @"2017.2.12 12:22";
    [self.timelabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.bottom).offset([UIView setHeight:8]);
        make.left.equalTo(self.typeLabel);
    }];

    
    self.moneyLabel = [[UILabel alloc]init];
    self.moneyLabel.font = [UIFont systemFontOfSize:12];
    self.moneyLabel.textColor = SF_COLOR(219, 3, 3);
    [self.contentView addSubview:self.moneyLabel];
    self.moneyLabel.text = @"+123.0元";
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(-[UIView setHeight:12]);
    }];

    UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:59.5 andWidth:375 andHeight:0.5]];
    label.backgroundColor = SF_COLOR(232, 232, 232);
    [self.contentView addSubview:label];
}
- (void)reloadWith:(MakeModel *)model {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
