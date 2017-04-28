//
//  AppDelegate.m
//  KaiWan
//
//  Created by chenguang on 17/3/2.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "MainViewController.h"
#import "MakeDiscipleViewController.h"
#import "BangDViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <AdSupport/ASIdentifierManager.h>

@interface AppDelegate ()
{
    FirstViewController *_firstViewController;
    UINavigationController *_firstNagv;
    
    SecondViewController *_secondViewController;
    UINavigationController *_secondNagv;
    
    MakeDiscipleViewController *_thirdViewController;
    UINavigationController *_thirdNagv;
    
    FourViewController *_fourViewController;
    UINavigationController *_fourNagv;

}
@end

@implementation AppDelegate


/**
 设置rootViewController为壳子
 */
- (void)setRootViewControllerWithShell{
    
    self.gameViewController = [[EAGameViewController alloc] init];
    self.window.rootViewController = self.gameViewController;
    [self.window makeKeyAndVisible];
}


/**
 设置rootViewController为开玩
 */
- (void)setRootViewControllerWithKaiWan{
    
    //开玩
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self  initShare];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *str1 = [user valueForKey:@"userid"];
    self.uid = @"";
    if (str1.length>0) {
        self.uid = str1;
        self.headIcon = [user valueForKey:@"usericon"];
        self.nickName = [user valueForKey:@"username"];
        self.idfa = [user valueForKey:@"idfa"];
        self.window.rootViewController = [self creatRootController];
    }else {
        
        self.window.rootViewController = [[BangDViewController alloc]init];
        
    }
    
    [self.window makeKeyAndVisible];
    
}


/**
 设置rootViewController为一个等待视图
 */
- (void)setHoldOnViewController{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController *VC = [[UIViewController alloc] init];
    
    UIActivityIndicatorView *testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    testActivityIndicator.center = VC.view.center;//只能设置中心，不能设置大小
    [testActivityIndicator startAnimating];
    [testActivityIndicator setHidesWhenStopped:YES];
    [VC.view addSubview:testActivityIndicator];
    
    self.window.rootViewController = VC;
    [self.window makeKeyAndVisible];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setHoldOnViewController];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isKaiWan"] intValue] == 1) {
        [self setRootViewControllerWithKaiWan];
    } else {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://api.ikaiwan.com/Config.html"]];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        DLog(@"%@", dataDic);
        
        if ([dataDic[@"code"] intValue] == 1) {
            [self setRootViewControllerWithShell];
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isKaiWan"];
        } else {
            [self setRootViewControllerWithKaiWan];
        }
    }
    
   
    return YES;
}
- (void)pushMainTabview {
    self.window.rootViewController = [self creatRootController];
    [self.window makeKeyAndVisible];
}
- (void)initShare {
    [[UMSocialManager defaultManager] openLog:YES];

    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58feeacb75ca35124b001340"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx92790f9f31a16759" appSecret:@"41128b884506defc9e5d20c8ea52f317" redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置分享到QQ互联的appID
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105840863"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (UIViewController *)creatRootController {
    
    _firstViewController = [[FirstViewController alloc]init];
    _firstNagv = [[UINavigationController alloc]initWithRootViewController:_firstViewController];
    UITabBarItem *conItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"首页"] selectedImage:[UIImage imageNamed:@"首页点"]];
    _firstNagv.tabBarItem = conItem;
    _firstViewController.title = @"首页";
    
    
    
    _secondViewController = [[SecondViewController alloc]init];
    _secondNagv = [[UINavigationController alloc]initWithRootViewController:_secondViewController];
    UITabBarItem *conItem1 = [[UITabBarItem alloc]initWithTitle:@"赚钱" image:[UIImage imageNamed:@"赚钱"] selectedImage:[UIImage imageNamed:@"赚钱点"]];
    _secondNagv.tabBarItem = conItem1;
    _secondViewController.title = @"赚钱";
    
    
    
    _thirdViewController = [[MakeDiscipleViewController alloc]init];
    _thirdNagv = [[UINavigationController alloc]initWithRootViewController:_thirdViewController];
    UITabBarItem *conItem2 = [[UITabBarItem alloc]initWithTitle:@"收徒" image:[UIImage imageNamed:@"收徒"] selectedImage:[UIImage imageNamed:@"收徒点"]];
    _thirdNagv.tabBarItem = conItem2;
    _thirdViewController.title = @"收徒";
    
    
    
    _fourViewController = [[FourViewController alloc]init];
    _fourNagv = [[UINavigationController alloc]initWithRootViewController:_fourViewController];
    UITabBarItem *conItem3 = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"我的"] selectedImage:[UIImage imageNamed:@"我的点"]];
    _fourNagv.tabBarItem = conItem3;
    _fourViewController.title = @"我的";
    
    MainViewController *mainvc = [[MainViewController alloc]init];
    mainvc.viewControllers = @[_firstNagv,_secondNagv,_thirdNagv,_fourNagv];
    
    return mainvc;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}




- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:self.uid forKey:@"userid"];
    [user setObject:self.headIcon forKey:@"usericon"];
    [user setObject:self.nickName forKey:@"username"];
    [user setObject:self.idfa forKey:@"idfa"];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {


        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://api.ikaiwan.com/Config.html"]];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        DLog(@"%@", dataDic);
        
        if ([dataDic[@"code"] intValue] != 1) {
            
            NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
            if (![self.idfa isEqualToString:idfa]) {
                MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.window.rootViewController.view animated:YES];
                hub.label.text = @"您的IDFA发生改变，请重新登录，如有疑问请联系客服";
                hub.mode = MBProgressHUDModeText;
                [hub hideAnimated:YES afterDelay:1.5f];
                self.idfa = idfa;
                self.window.rootViewController = [[BangDViewController alloc]init];
            }
            
        }

}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:self.uid forKey:@"userid"];
    [user setObject:self.headIcon forKey:@"usericon"];
    [user setObject:self.nickName forKey:@"username"];
    [user setObject:self.idfa forKey:@"idfa"];
    
}


@end
