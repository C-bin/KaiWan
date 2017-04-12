//
//  PostPhoneViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/12.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "PostPhoneViewController.h"

@interface PostPhoneViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIButton *postBtn;
@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *codeTf;


@end

@implementation PostPhoneViewController
{
    UIButton *makeSureBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"手机验证码";
    [self setNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUI];
}
- (void)setUI {
    UIImageView *headImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123123.png"]];
    [self.view addSubview:headImage];
    
    [headImage makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.bgview.bottom).offset([UIView setHeight:42]);
        make.height.width.equalTo([UIView setHeight:65]);
    }];
    
    UILabel *title = [UILabel creatLabelWithFont:15 andbgcolor:nil andtextColor:SF_COLOR(102, 152, 228) andAligment:NSTextAlignmentCenter];
    title.text = @"为了更好的体验，请绑定手机号";
    [self.view addSubview:title];
    [title makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(headImage.bottom).offset([UIView setHeight:16]);
    }];
    UILabel *linelabel = [[UILabel alloc]init];
    linelabel.backgroundColor = SF_COLOR(232, 232, 232);
    [self.view addSubview:linelabel];
    
    [linelabel makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.left.equalTo([UIView setWidth:12]);
        make.right.equalTo(-[UIView setWidth:12]);
        make.top.equalTo(headImage.bottom).offset([UIView setHeight:94]);
        
    }];
    
    
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户"]];
    [self.view addSubview:image1];
    [image1 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(linelabel.top);
        make.left.equalTo(linelabel);
        make.width.height.equalTo([UIView setWidth:30]);
    }];
    
    
    self.phoneTf = [[UITextField alloc]init];
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:@"请输入手机号"];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(197, 197, 197) range:NSMakeRange(0, 6)];
    self.phoneTf.attributedPlaceholder = mstr;
    self.phoneTf.font = [UIFont systemFontOfSize:15];
    self.phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.phoneTf];
    
    [self.phoneTf makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image1.right);
        make.height.bottom.equalTo(image1);
        make.right.equalTo(self.view.right).offset(-[UIView setWidth:102]);
        
    }];
    
    UILabel *linelabel1 = [[UILabel alloc]init];
    linelabel1.backgroundColor = SF_COLOR(232, 232, 232);
    [self.view addSubview:linelabel1];
    
    [linelabel1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(linelabel);
        make.top.equalTo(linelabel.bottom).offset([UIView setHeight:46]);
        make.height.equalTo(1);
        
    }];
    
    UIImageView *image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"验证码"]];
    [self.view addSubview:image2];

    [image2 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(linelabel1.top);
        make.left.equalTo(linelabel1);
        make.width.height.equalTo([UIView setWidth:30]);

    }];
    
    self.codeTf = [[UITextField alloc]init];
    NSMutableAttributedString *mstr1 = [[NSMutableAttributedString alloc]initWithString:@"请输入验证码"];
    [mstr1 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(197, 197, 197) range:NSMakeRange(0, 6)];
    self.codeTf.attributedPlaceholder = mstr1;
    self.codeTf.font = [UIFont systemFontOfSize:15];
    self.codeTf.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.codeTf];
    [self.codeTf makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image2.right);
        make.height.bottom.equalTo(image2);
        make.right.equalTo(self.view.right).offset(-[UIView setWidth:102]);
    }];
    
    self.postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.postBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    self.postBtn.layer.borderWidth = 1;
    self.postBtn.layer.cornerRadius = 5;
    self.postBtn.clipsToBounds = YES;
    self.postBtn.backgroundColor = SF_COLOR(28, 108, 229);
    self.postBtn.layer.borderColor = SF_COLOR(169,169,169).CGColor;
    [self.postBtn setTitleColor:SF_COLOR(255,255,255) forState:UIControlStateNormal];
    [self.postBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.postBtn addTarget:self action:@selector(openCountdown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.postBtn];
    [self.phoneTf addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventAllEditingEvents];
    [self.codeTf addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventAllEditingEvents];
    [self.postBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTf.right);
        make.bottom.equalTo(linelabel.top);
        make.width.equalTo([UIView setWidth:90]);
        make.height.equalTo([UIView setHeight:32]);
    }];
    
    self.phoneTf.delegate = self;
    self.codeTf.delegate = self;
    
    makeSureBtn = [[UIButton alloc]init];
    [makeSureBtn setTitle:@"确定绑定" forState:UIControlStateNormal];
    [makeSureBtn setTitleColor:SF_COLOR(255, 255, 255) forState:UIControlStateNormal];
    makeSureBtn.backgroundColor = SF_COLOR(139, 185, 255);
    makeSureBtn.layer.cornerRadius = 4;
    makeSureBtn.clipsToBounds = YES;
    makeSureBtn.userInteractionEnabled = NO;
    [makeSureBtn addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeSureBtn];
    [makeSureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linelabel1.bottom).offset([UIView setHeight:39]);
        make.width.equalTo([UIView setWidth:351]);
        make.left.equalTo([UIView setWidth:12]);
        make.height.equalTo([UIView setHeight:44]);
    }];
    
}
- (void)makeSure {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSDictionary *dic=@{
                        @"uid":del.uid,
                        @"code":self.codeTf.text,
                        @"mobile":self.phoneTf.text
                        };
    [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@User/moblie.html",HostUrl] parameters:dic sucsess:^(id response) {
        
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:nil message:@"绑定成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        [alert1 addAction:act];
        [self presentViewController:alert1 animated:YES completion:^{
            
        }];
        
    } fail:^(NSError *error) {
        
    } andViewController:self];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneTf resignFirstResponder];
    [self.codeTf resignFirstResponder];
    
}
-(void)openCountdown{
    //716992
    if (self.phoneTf.text.length!=11) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入正确的电话号码" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.postBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.postBtn setTitleColor:SF_COLOR(255, 255, 255) forState:UIControlStateNormal];
                self.postBtn.backgroundColor = SF_COLOR(28, 108, 229);
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.postBtn setTitleColor:SF_COLOR(169, 169, 169) forState:UIControlStateNormal];
                NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2ds后重发",seconds]];
                [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(28, 108, 229) range:NSMakeRange(0, 3)];
                self.postBtn.titleLabel.attributedText = mstr;
                self.postBtn.backgroundColor = SF_COLOR(255, 255, 255);
                self.postBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
    [self postBtnClick];
}
- (void)valueChange {
    
    if (self.codeTf.text.length&&self.phoneTf.text.length) {
        makeSureBtn.backgroundColor = SF_COLOR(28, 108, 229);
        makeSureBtn.userInteractionEnabled = YES;
        
    }else {
        makeSureBtn.backgroundColor = SF_COLOR(139, 185, 255);
        makeSureBtn.userInteractionEnabled = NO;
    }
}

- (void)postBtnClick {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Sms.html?uid=%@&mobile=%@",HostUrl,del.uid,self.phoneTf.text] parameters:nil sucsess:^(id response) {
        
        
    } fail:^(NSError *error) {
        
        
    } andViewController:self];
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
