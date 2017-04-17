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


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.uid = @"2";
    self.window.rootViewController = [self creatRootController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
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
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
