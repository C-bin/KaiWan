//
//  BangDViewController.m
//  KaiWan
//
//  Created by chenguang on 17/3/15.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "BangDViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <AdSupport/ASIdentifierManager.h>
#import "sys/utsname.h"

@interface BangDViewController ()
@property (nonatomic, strong)UITextField *phoneNumText;
@property (nonatomic, strong)UITextField *yanNumText;
@property (nonatomic, strong)UIButton *pushButton;
@end

@implementation BangDViewController
{
    UIButton *btn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [self creatUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)creatUI {
    UIImageView *image = [[UIImageView alloc]initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"1背景"];
    [self.view addSubview:image];
    image.userInteractionEnabled = YES;
    btn = [[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageNamed:@"微信登录"] forState:UIControlStateNormal];
    [image addSubview:btn];
    [btn addTarget:self action:@selector(pushYanNum) forControlEvents:UIControlEventTouchUpInside];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-HeightScale(48));
        make.centerX.equalTo(image.centerX);
        make.width.equalTo(WidthScale(140));
        make.height.equalTo(HeightScale(40));
    }];
}
- (void)pushYanNum {
//    btn.userInteractionEnabled = NO;
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    int h =self.view.bounds.size.height;
    int w = self.view.bounds.size.width;
    struct utsname systemInfo;
    uname(&systemInfo);
    UIDevice *device_=[[UIDevice alloc] init];
    NSString * os=device_.systemVersion;
    NSString * pn=[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString * name=device_.name;


    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
//        btn.userInteractionEnabled = YES;

        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.gender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            
            NSDictionary *parameters = @{
                                         @"idfa":idfa,
                                         @"app":@"",
                                         @"name":name,
                                         @"pn":pn,
                                         @"os":os,
                                         @"type":@"ios",
                                         @"ver":@"4.0",
                                         @"w": [NSString stringWithFormat :@"%d",w],
                                         @"h": [NSString stringWithFormat:@"%d",h],
                                         @"openid":resp.uid,
                                         @"nickname":resp.name,
                                         @"headimgurl":resp.iconurl,
                                         };
            
            [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Regist.html",HostUrl] parameters:parameters sucsess:^(id response) {
                
                NSDictionary *dic = (NSDictionary *)response;
                NSLog(@"%@",dic);
                NSDictionary *data = dic[@"data"];
                del.uid = [NSString creatWithId:data[@"id"]];

                if (self.navigationController) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else {
                    [del pushMainTabview];
                }
                
            } fail:^(NSError *error) {
                NSLog(@"%@",error);
            } andViewController:self];

        }
        
        
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
