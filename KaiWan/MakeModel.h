//
//  MakeModel.h
//  KaiWan
//
//  Created by chenguang on 17/4/5.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "JSONModel.h"

@interface MakeModel : JSONModel
@property (nonatomic,strong) NSString *type_name;
@property (nonatomic,strong) NSString *info;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *timec;
@property (nonatomic,strong) NSString *img;

@end
