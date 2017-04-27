//
//  ChartsTableViewCell.m
//  KaiWan
//
//  Created by chenguang on 17/4/7.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "ChartsTableViewCell.h"

@implementation ChartsTableViewCell
{
    UIImageView *headicon;
    UIImageView *headimagel;
    UILabel *numLabel;
    UIImageView *numImage;
    UILabel *namelabel;
    UILabel *disNumlabel;
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
    headicon = [[UIImageView alloc]init];
    headicon.layer.cornerRadius = [UIView setHeight:28];
    headicon.clipsToBounds = YES;
    [self.contentView addSubview:headicon];
    
    numImage = [[UIImageView alloc]init];
    [self.contentView addSubview:numImage];
    headimagel = [[UIImageView alloc]init];
    [self.contentView addSubview:headimagel];
    
    numLabel = [UILabel creatLabelWithFont:12 andbgcolor:SF_COLOR(112, 163, 241) andtextColor:[UIColor whiteColor] andAligment:NSTextAlignmentCenter];
    numLabel.clipsToBounds = YES;
    numLabel.layer.cornerRadius = [UIView setWidth:8.5];
    numLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    numLabel.layer.borderWidth = 0.5;
    [self.contentView addSubview:numLabel];
    
    namelabel = [UILabel creatLabelWithFont:16 andbgcolor:nil andtextColor:SF_COLOR(51, 51, 51) andAligment:0];
    [self.contentView addSubview:namelabel];
    namelabel.text = @"另一个自己";
    disNumlabel = [UILabel creatLabelWithFont:13 andbgcolor:nil andtextColor:SF_COLOR(232, 132, 132) andAligment:0];
    [self.contentView addSubview:disNumlabel];
    disNumlabel.text = @"累计收徒:7";
    moneyLabel = [UILabel creatLabelWithFont:24 andbgcolor:nil andtextColor:SF_COLOR(28, 108, 229) andAligment:NSTextAlignmentRight];
    [self.contentView addSubview:moneyLabel];
    
    [headicon makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo([UIView setWidth:12]);
        make.width.height.equalTo([UIView setHeight:56]);
    }];
    
    [namelabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headicon.right).offset([UIView setWidth:18]);
        make.bottom.equalTo(headicon.centerY).offset(-[UIView setHeight:4]);
    }];
    [disNumlabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headicon.right).offset([UIView setWidth:18]);
        make.top.equalTo(headicon.centerY).offset([UIView setHeight:4]);

    }];
    [moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-[UIView setWidth:12]);
        make.centerY.equalTo(self.contentView);
    }];
    
    UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:87 andWidth:375 andHeight:1]];
    linelabel.backgroundColor = SF_COLOR(232, 232, 232);
    [self.contentView addSubview:linelabel];
}
- (void)reloadWithIndex:(NSIndexPath *)index {
    if (index.row<3) {
        numImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"NO.%ld",index.row+1]];
        [numImage updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headicon);
            make.bottom.equalTo(headicon.bottom);
            make.height.equalTo([UIView setHeight:18]);
            make.width.equalTo([UIView setWidth:56]);
        }];
        headimagel.image =[UIImage imageNamed:[NSString stringWithFormat:@"皇冠%ld",index.row+1]];
        [headimagel updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(headicon.top).offset([UIView setHeight:12]);
            make.left.equalTo(headicon.right).offset(-[UIView setWidth:20]);
            make.height.equalTo([UIView setHeight:24]);
            make.width.equalTo([UIView setWidth:27]);
        }];
        [numLabel updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(0);
        }];
        namelabel.font = [UIFont systemFontOfSize:18];
        disNumlabel.font = [UIFont systemFontOfSize:14];
    }else {
        numLabel.text = [NSString stringWithFormat:@"%ld",index.row+1];
        [numLabel updateConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(headicon);
            make.width.height.equalTo([UIView setHeight:17]);
        }];
        [headimagel updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(0);
        }];
        [numImage updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(0);
        }];
        namelabel.font = [UIFont systemFontOfSize:16];
        disNumlabel.font = [UIFont systemFontOfSize:13];
    }
    NSMutableAttributedString *mst = [[NSMutableAttributedString alloc]initWithString:@"103元"];
    [mst addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(3, 1)];
    moneyLabel.attributedText = mst;
    
}

- (void)setRankDic:(NSDictionary *)rankDic{
    _rankDic = rankDic;
    [headicon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", ImageUrl, rankDic[@"avatar"]]] placeholderImage:[UIImage imageNamed:@"默认头像.png"]];
    disNumlabel.text = [NSString stringWithFormat:@"累计收徒:%@", rankDic[@"invite_count"]];
    moneyLabel.text = [NSString stringWithFormat:@"%@元", rankDic[@"money"]];
    namelabel.text = rankDic[@"name"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
