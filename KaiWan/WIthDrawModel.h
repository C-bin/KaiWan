//
//  WIthDrawModel.h
//  KaiWan
//
//  Created by chenguang on 17/4/21.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "JSONModel.h"

@interface WIthDrawModel : JSONModel
@property (nonatomic,strong) NSString *tid;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *rtime;

@end
