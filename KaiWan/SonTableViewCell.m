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
//    titleLabel.text = @"2011.3.12邀请其有此女为徒";
    [self.contentView addSubview:titleLabel];
        moneyLabel = [[UILabel alloc]init];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([UIView setWidth:12]);
        make.height.top.equalTo(self.contentView);
    }];
//    moneyLabel.text = @"+1.2元";
    moneyLabel.font = [UIFont systemFontOfSize:12];
    moneyLabel.textColor = SF_COLOR(219, 3, 3);
    [self.contentView addSubview:moneyLabel];
    moneyLabel.textAlignment = NSTextAlignmentRight;
    [moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.right).offset(-[UIView setWidth:12]);
        make.top.height.equalTo(self.contentView);
    }];
    UILabel *linelabel = [[UILabel alloc]init];
    linelabel.backgroundColor = SF_COLOR(229, 229, 229);
    [self.contentView addSubview:linelabel];
    [linelabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(1);
        
    }];
}
- (void)reloadwithDic:(NSDictionary *)dic  andIsInvite:(int)isInvite{
    if (isInvite==0) {
        long long time=[[NSString creatWithId:dic[@"time"]] longLongValue];
        NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        NSString*timeString=[formatter stringFromDate:d];
        NSString *str = [NSString stringWithFormat:@"%@邀请%@为徒",timeString,dic[@"nickname"]];
        NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:str];
        [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(28, 108, 229) range:NSMakeRange(timeString.length+2, [NSString creatWithId:dic[@"nickname"]].length)];
        titleLabel.attributedText = mstr;
        moneyLabel.text = @"";
    }else {
        long long time=[[NSString creatWithId:dic[@"timec"]] longLongValue];
        NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        NSString*timeString=[formatter stringFromDate:d];
        NSString *str = [NSString stringWithFormat:@"%@%@%@",dic[@"nickname"],timeString,dic[@"info"]];
        NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:str];
        [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(28, 108, 229) range:NSMakeRange(0, [NSString creatWithId:dic[@"nickname"]].length)];
        titleLabel.attributedText = mstr;
        
        NSString *moneystr = [NSString stringWithFormat:@"+%@元",[NSString creatWithId:dic[@"money"]]];
        NSMutableAttributedString *moneyMstr =[[NSMutableAttributedString alloc]initWithString:moneystr];
        [moneyMstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 1)];
        [moneyMstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(1, [NSString creatWithId:dic[@"money"]].length)];
        moneyLabel.attributedText = moneyMstr;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
