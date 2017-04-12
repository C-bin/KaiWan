//
//  RequestData.m
//  KaiWan
//
//  Created by chenguang on 17/4/11.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "RequestData.h"

@implementation RequestData
+ (void)GetDataWithURL:(NSString *)url parameters:(NSDictionary*)parameters sucsess:(NetworkingSucsess)sucsess fail:(NetworkingFail)fail andViewController:(UIViewController *)veiwCV{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    MBProgressHUD *mb ;
    if (veiwCV) {
      mb = [MBProgressHUD showHUDAddedTo:veiwCV.view animated:YES];
    }
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manager.responseSerializer = response;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [mb hideAnimated:YES];
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSNumber *num = dic[@"code"];
        if (num.integerValue!=1) {
            MBProgressHUD *mbpr = [MBProgressHUD showHUDAddedTo:veiwCV.view animated:YES];
            mbpr.label.text = dic[@"message"];
            [mbpr hideAnimated:YES afterDelay:2];
            return ;
        }
        sucsess(responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
        [mb hideAnimated:YES];

    }];
    
}
+ (void)PostDataWithURL:(NSString *)url parameters:(NSDictionary*)parameters sucsess:(NetworkingSucsess)sucsess fail:(NetworkingFail)fail andViewController:(UIViewController *)veiwCV {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    if (veiwCV!=nil) {
        [MBProgressHUD showHUDAddedTo:veiwCV.view animated:YES];

    }
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sucsess(responseObject);
        
        if (veiwCV) {
            [MBProgressHUD hideHUDForView:veiwCV.view animated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
        if (veiwCV) {
            [MBProgressHUD hideHUDForView:veiwCV.view animated:YES];
        }
    }];
}
@end

