//
//  BangDViewController.m
//  KaiWan
//
//  Created by chenguang on 17/3/15.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "BangDViewController.h"

@interface BangDViewController ()
@property (nonatomic, strong)UITextField *phoneNumText;
@property (nonatomic, strong)UITextField *yanNumText;
@property (nonatomic, strong)UIButton *pushButton;
@end

@implementation BangDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
- (void)creatUI {
    UIImageView *image = [[UIImageView alloc]initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"1背景"];
    [self.view addSubview:image];
    
    UIButton *btn = [[UIButton alloc]init];
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
