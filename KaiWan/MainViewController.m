//
//  MainViewController.m
//  KaiWan
//
//  Created by chenguang on 17/3/2.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "MainViewController.h"
#import "FourViewController.h"
#define WEIGHT [UIScreen mainScreen].bounds.size.width/5

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
@interface MainViewController ()<UITabBarControllerDelegate>

@end

@implementation MainViewController
{
    NSString *_tmpLb;
    NSInteger _buttag;
    
    UINavigationController *_tmpNav;
    UILabel * _tmpLabel;
    UIImageView * _tmpImageView;
    UIImageView * _imageView;
    UIButton * _tmpButton;
    //UIView * _tmpView;
    UIView *blackView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushto:) name:@"pushtomain" object:nil];

}
- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
    NSArray * subViews = self.tabBar.subviews;
    
    for (UIView * view in subViews) {
        
        view.hidden = YES;
        
    }
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)pushto :(NSNotification *)n {
    
    NSDictionary *dic = n.userInfo;
    
    NSString *str = dic[@"num"];
    
    
    UIButton *btn = (UIButton *)[self.tabBar viewWithTag:500-1+str.intValue];
    
    [self buttonClick:btn];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSArray * arr = self.viewControllers;
    for (int i = 0; i < arr.count ; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(i*SCREEN_W/arr.count, 0, SCREEN_W/arr.count, 49)];
        
        button.tag = 500 +i;
        
        [self.tabBar addSubview:button];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(button.bounds.size.width/2.0-16,0, 32, 32)];
            
            [button addSubview:_imageView];
        
        _imageView.tag = 100 + i;
        
        UINavigationController * nav = [arr objectAtIndex:i];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0+3.0/375*SCREEN_W, 34, SCREEN_W/arr.count*1.0, 13)];
        label.text = nav.tabBarItem.title;
        label.textColor = [RGBColor colorWithHexString:@"#333333"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [button addSubview:label];
        if (i == 0) {
            _imageView.image = nav.tabBarItem.selectedImage;
            [label setTextColor:[RGBColor colorWithHexString:@"1c6ce5"]];
            _tmpImageView = _imageView;
            _tmpLabel = label;
            _tmpNav = nav;
            _tmpButton = button;
        }else {
            _imageView.image = nav.tabBarItem.image;
            
        }
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}
- (void)buttonClick:(UIButton *)button{
    
    if (button == _tmpButton) {
        return;
    }
    
    UIImageView * imageView = (UIImageView *)[button.subviews firstObject];
    
    UINavigationController * nav = [self.viewControllers objectAtIndex:imageView.tag-100];
    
    imageView.image = nav.tabBarItem.selectedImage;
    UILabel * label = (UILabel *)[button.subviews lastObject];
    [label setTextColor:[RGBColor colorWithHexString:@"1c6ce5"]];
    if (imageView.tag == 103) {
        
//        FourViewController *notice=(FourViewController *)nav.topViewController;
//        [notice reloadData];
    }

    // 设置上一次的按钮为低亮
    _tmpImageView.image = _tmpNav.tabBarItem.image;
    [_tmpLabel setTextColor:[RGBColor colorWithHexString:@"#333333"]];
    
    // 重新设置高亮的临时变量
    _tmpLabel = label;
    _tmpImageView = imageView;
    _tmpNav = nav;
    _tmpButton = button;
    [nav popToRootViewControllerAnimated:YES];
    
    // 设置界面的切换
    self.selectedIndex = imageView.tag - 100;
    
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
