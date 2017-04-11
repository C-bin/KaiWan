//
//  SonTableViewCell.m
//  KaiWan
//
//  Created by chenguang on 17/4/5.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "SonTableViewCell.h"

@implementation SonTableViewCell
{
    UILabel *titleLabel;
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
    titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.text = @"2011.3.12邀请其有此女为徒";
    [self.contentView addSubview:titleLabel];
    
    
    moneyLabel = [[UILabel alloc]init];
    moneyLabel.text = @"+1.2元";
    moneyLabel.textColor = SF_COLOR(219, 3, 3);
    
    [self.contentView addSubview:moneyLabel];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
