//
//  NSString+Creat.m
//  KaiWan
//
//  Created by chenguang on 17/4/11.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "NSString+Creat.h"

@implementation NSString (Creat)
+ (NSString *)creatWithId:(id)objc {
    NSString *str  = [NSString stringWithFormat:@"%@",objc];
    return str;
}
@end
