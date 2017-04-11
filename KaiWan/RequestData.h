//
//  RequestData.h
//  KaiWan
//
//  Created by chenguang on 17/4/11.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"
typedef void(^NetworkingSucsess)(id response);
typedef void(^NetworkingFail)(NSError *error);
@interface RequestData : NSObject
+ (void)GetDataWithURL:(NSString *)url parameters:(NSDictionary*)parameters sucsess:(NetworkingSucsess)sucsess fail:(NetworkingFail)fail andViewController:(UIViewController *)veiwCV;
+ (void)PostDataWithURL:(NSString *)url parameters:(NSDictionary*)parameters sucsess:(NetworkingSucsess)sucsess fail:(NetworkingFail)fail andViewController:(UIViewController *)veiwCV;

@end
