//
//  SignInViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/17.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "SignInViewController.h"
#import "TurntableView.h"
#import <UShareUI/UShareUI.h>
@interface SignInViewController ()<CAAnimationDelegate>
@property (nonatomic,strong) UILabel *qdLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) TurntableView * turntable;
@property (nonatomic,assign) NSInteger days;
@property (nonatomic,assign) BOOL isSign;
@end

@implementation SignInViewController
{
    UIButton *btn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"签到赚钱";
    [self setNavigationBar];
    [self creatUI];
    [self request];
}
- (void)request {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Sign.html?uid=%@",HostUrl,del.uid] parameters:nil sucsess:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        NSDictionary *data = dic[@"data"];
        NSArray *arr = data[@"list"];
        NSString *days = [NSString creatWithId:data[@"days"]];
        //CGRectMake([UIView setWidth:12+i*53], HeightScale(164), WidthScale(0), HeightScale(12))
        NSString *sign = [NSString creatWithId:data[@"is_sign"]];
        if ([sign isEqualToString:@"1"]) {
            btn.userInteractionEnabled = NO;
            [btn setTitle:@"已签到" forState:UIControlStateNormal];
        }
        self.days = [days integerValue];
        for (int i = 0; i < days.intValue; i++) {
            UIImageView *image1 = (UIImageView *)[self.view viewWithTag:300+i];
            image1.image = [UIImage imageNamed:@"已签到状态"];
            UIImageView *image2 = (UIImageView *)[self.view viewWithTag:310+i];
            image2.frame = CGRectMake([UIView setWidth:12+i*53], HeightScale(164), WidthScale(12), HeightScale(12));
            if (i>3) {
                UIImageView *image3 = (UIImageView *)[self.view viewWithTag:320+i];
                [image3 removeFromSuperview];
            }
        }
        NSMutableArray *mstr = [NSMutableArray array];
        for (id objc in arr) {
            [mstr addObject:[NSString creatWithId:objc]];
        }
        for (id objc in arr) {
            [mstr addObject:[NSString creatWithId:objc]];
        }
        
        self.turntable.numberArray = mstr;
        
    } fail:^(NSError *error) {
        
    } andViewController:self];
}
- (void)creatUI {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];

    UIImageView *bgimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, HeightScale(958))];
    bgimage.image = [UIImage imageNamed:@"123"];
    [scrollView addSubview:bgimage];
    
    scrollView.contentSize = CGSizeMake(SWIDTH, HeightScale(958));
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    [bgimage addSubview:btn];
    btn.layer.cornerRadius = HeightScale(95/2.0);
    btn.clipsToBounds = YES;
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(HeightScale(15));
        make.centerX.equalTo(0);
        make.width.height.equalTo(HeightScale(95));
    }];
    [btn setTitle:@"签到" forState:UIControlStateNormal];
    [btn setTitleColor:SF_COLOR(28, 108, 229) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:27];
    self.qdLabel = [UILabel creatLabelWithFont:25.2 andbgcolor:nil andtextColor:SF_COLOR(28, 108, 229) andAligment:NSTextAlignmentCenter];
    [btn addSubview:self.qdLabel];
//    self.qdLabel.text = @"签到";
    [btn addTarget:self action:@selector(signBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.qdLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(HeightScale(24));
    }];
    
    
    self.moneyLabel = [UILabel creatLabelWithFont:14 andbgcolor:nil andtextColor:SF_COLOR(28, 108, 229) andAligment:NSTextAlignmentCenter];
//    self.moneyLabel.text = @"+0.02元";
    [btn addSubview:self.moneyLabel];
    
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qdLabel.bottom).offset(HeightScale(10));
        make.centerX.equalTo(0);
    }];
    UIView *impView=nil;
    
    for (int i = 0; i < 7; i++) {
        UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:18+i*53], HeightScale(170), WidthScale(18), WidthScale(18))];
        image1.image = [UIImage imageNamed:@"没签到状态"];
        if (i>3) {
            image1.image = [UIImage imageNamed:@"徒弟签到"];

        }
        [bgimage addSubview:image1];
        image1.tag = 300+i;
        
        UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image1.frame), HeightScale(170)+WidthScale(9), WidthScale(35), 1)];
        linelabel.backgroundColor = SF_COLOR(28, 102, 217);
        if (i!=6) {
            [bgimage addSubview:linelabel];

        }
        //16
        UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:12+i*53], HeightScale(164), WidthScale(0), HeightScale(12))];
        image2.image = [UIImage imageNamed:@"装饰"];
        [bgimage addSubview:image2];
        image2.tag = 310+i;
        
        UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:19.5+i*53], HeightScale(152), WidthScale(15), WidthScale(15))];
        image3.image = [UIImage imageNamed:@"礼物"];
        if (i>3) {
            [bgimage addSubview:image3];
        }
        image3.tag = 320+i;
        
        
        UILabel *daylabel = [UILabel creatLabelWithFont:12 andbgcolor:nil andtextColor:SF_COLOR(28, 108, 229) andAligment:NSTextAlignmentCenter];
        daylabel.text = [NSString stringWithFormat:@"第%d天",i+1];
        [bgimage addSubview:daylabel];
        [daylabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(image1);
            make.top.equalTo(image1.bottom).offset(HeightScale(12));
        }];
        impView = daylabel;
    }
    
    bgimage.userInteractionEnabled = YES;
    // 转盘View
    self.turntable = [[TurntableView alloc] initWithFrame:CGRectMake([UIView setWidth:(375-224)/2], HeightScale(281)+WidthScale(18), WidthScale(224), WidthScale(224))];
    
    [self.turntable.playButton addTarget:self action:@selector(startAnimaition) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:self.turntable];

    UIButton *btn1 = [UIButton creatButtonWithTitle:@"分享给好友" andBgColor:SF_COLOR(28, 108, 229) andTextColor:SF_COLOR(255, 255, 255) andtitleFont:23];
    [btn1 addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgimage addSubview:btn1];
    btn1.layer.cornerRadius = 10;
    btn1.clipsToBounds = YES;
    [btn1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.turntable.bottom).offset([UIView setHeight:22+47]);
        make.width.equalTo([UIView setWidth:294]);
        make.centerX.equalTo(0);
        make.height.equalTo([UIView setHeight:44]);
    }];
    
}
- (void)signBtn:(UIButton *)btn {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Sign.html?uid=%@&type=sign",HostUrl,del.uid] parameters:nil sucsess:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        if (response) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSDictionary *dic = (NSDictionary *)response;
            
            // Set the text mode to show only text.
            hud.mode = MBProgressHUDModeText;
            hud.label.text = [NSString creatWithId:dic[@"message"]];
            hud.offset = CGPointMake(0.f, 0);
            [hud hideAnimated:YES afterDelay:2.f];

        }else {
            return ;
        }
        NSString *code = [NSString creatWithId:dic[@"code"]];
        if (code.integerValue==1) {
            self.days+=1;
        }
        for (int i = 0; i < self.days; i++) {
            UIImageView *image1 = (UIImageView *)[self.view viewWithTag:300+i];
            image1.image = [UIImage imageNamed:@"已签到状态"];
            UIImageView *image2 = (UIImageView *)[self.view viewWithTag:310+i];
            image2.frame = CGRectMake([UIView setWidth:12+i*53], HeightScale(164), WidthScale(12), HeightScale(12));
            if (i>3) {
                UIImageView *image3 = (UIImageView *)[self.view viewWithTag:320+i];
                [image3 removeFromSuperview];
            }
        }
        
    } fail:^(NSError *error) {
        
    } andViewController:nil];
    

}

-(void)startAnimaition
{
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Sign.html?type=prize&uid=%@",HostUrl,del.uid] parameters:nil sucsess:^(id response) {
        NSInteger turnAngle=0;
        NSInteger turnsNum = 5;//控制圈数
        NSDictionary *dic = (NSDictionary *)response;
        NSNumber *num = dic[@"code"];
        if (num.integerValue!=1) {
            
            return ;
        }
        NSDictionary *data = dic[@"data"];
        NSString *item = [NSString creatWithId:data[@"item"]];

        int i = 0;
        switch (item.integerValue) {
            case 0:
                i = 2;
                break;
            case 1:
                i=1;
                break;
            case 2:
                i = 0;
                break;
            case 3:
                i= 3;
                break;
                
            default:
                break;
        }
        turnAngle = 360/self.turntable.numberArray.count*(i+1);

        CGFloat perAngle = M_PI/180.0;
        
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat:turnAngle * perAngle + 360 * perAngle * turnsNum+M_PI /8];
        rotationAnimation.duration = 3.0f;
        rotationAnimation.cumulative = YES;
        rotationAnimation.delegate = self;
        //由快变慢
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        rotationAnimation.fillMode=kCAFillModeForwards;
        rotationAnimation.removedOnCompletion = NO;
        [self.turntable.rotateWheel.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        

        
    } fail:^(NSError *error) {
        
    } andViewController:self];
        // 转盘结束后调用，显示获得的对应奖励
//    self.label.text = [NSString stringWithFormat:@"恭喜您抽中%@",self.labelText];
    
}

- (void)shareClick:(UIButton *)btn {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxa1a41b8da8ec5f1d" appSecret:@"41a4c78cefb9354572e1d39a55f5c3f6" redirectURL:@"http://mobile.umeng.com/social"];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [self shareWebPageToPlatformType:platformType];
    }];
    
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString* thumbURL =  @"http://s2.vbokai.com/logo.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"和我一起来赚钱吧！" descr:@"欢迎使用开玩，这是一款利用用户闲暇时间赚钱的软件" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"http://s2.vbokai.com/share.html?code=%@",del.uid];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    shareObject.thumbImage = [UIImage imageNamed:@"123123.png"];

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        
    }];
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
