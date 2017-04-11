//
//  MakeTableViewCell.h
//  KaiWan
//
//  Created by chenguang on 17/4/5.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeModel.h"
@interface MakeTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *titlelabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *timelabel;
@property (nonatomic,strong) UILabel *moneyLabel;


- (void)reloadWith:(MakeModel *)model;

@end
