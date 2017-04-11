//
//  PersonMesgViewController.m
//  KaiWan
//
//  Created by chenguang on 17/3/31.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "PersonMesgViewController.h"

@interface PersonMesgViewController ()

@end

@implementation PersonMesgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"个人资料";
    [self setNavigationBar];
    [self creatUI];
}
- (void)creatUI {
    
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
