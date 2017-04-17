//
//  DeepTaskModel.m
//  KaiWan
//
//  Created by van7ish on 2017/4/14.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "DeepTaskModel.h"

@implementation DeepTaskModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id",
             @"Description" : @"description"};
}

@end
