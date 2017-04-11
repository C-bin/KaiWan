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
    self.phoneNumText = [[UITextField alloc]init];
    self.phoneNumText.frame = [UIView setRectWithX:50 andY:200 andWidth:275 andHeight:50];
    self.phoneNumText.placeholder = @"输入手机号码";
    self.phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.phoneNumText];
    self.yanNumText = [[UITextField alloc]init];
    self.yanNumText.frame = [UIView setRectWithX:50 andY:300 andWidth:275 andHeight:50];
    self.yanNumText.placeholder = @"请输入验证码";
    self.yanNumText.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.yanNumText];
    
    
    self.pushButton = [[UIButton alloc]init];
    [self.pushButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.pushButton addTarget:self action:@selector(pushYanNum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pushButton];
    
    self.pushButton.frame = [UIView setRectWithX:100 andY:400 andWidth:175 andHeight:50];
    
    
}
- (void)pushYanNum {
    if (self.phoneNumText.text.length==11) {
        
        // 请求接口
        self.pushButton.userInteractionEnabled = NO;
        
        
    }else {
        
    }
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneNumText resignFirstResponder];
    [self.yanNumText resignFirstResponder];
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
