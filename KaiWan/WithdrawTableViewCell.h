//
//  WithdrawTableViewCell.h
//  KaiWan
//
//  Created by chenguang on 17/4/5.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIthDrawModel.h"
@interface WithdrawTableViewCell : UITableViewCell
- (void)reloadWithModel:(WIthDrawModel *)model;
@end
