//
//  ChartsTableViewCell.h
//  KaiWan
//
//  Created by chenguang on 17/4/7.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartsTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary * rankDic;
- (void)reloadWithIndex:(NSIndexPath *)index;

@end
