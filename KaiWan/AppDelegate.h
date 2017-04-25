//
//  AppDelegate.h
//  KaiWan
//
//  Created by chenguang on 17/3/2.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic, strong)NSString *headIcon;
@property (nonatomic,strong) NSString  *nickName;
@property (nonatomic, assign)BOOL is_mobile;
@end

