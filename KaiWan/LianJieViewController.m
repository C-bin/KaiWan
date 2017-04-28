//
//  LianJieViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/13.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "LianJieViewController.h"
#import <UShareUI/UShareUI.h>
@interface LianJieViewController ()
@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic,strong) UILabel *nickNameLabel;
@property (nonatomic,strong) UILabel *idLabel;


@end

@implementation LianJieViewController
{
    UILabel *ulrLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"链接收徒";
    [self setNavigationBar];
    [self creatUI];
    self.view.backgroundColor = [UIColor whiteColor];
    [self reuqest];
}
- (void)reuqest{
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.idLabel.text = [NSString stringWithFormat:@"ID:%@",del.uid];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:del.headIcon]];
    self.nickNameLabel.text = del.nickName;
    [RequestData GetDataWithURL:[NSString stringWithFormat:@"%@Share/link.html?uid=%@",HostUrl,del.uid] parameters:nil sucsess:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        NSDictionary *data = dic[@"data"];
        ulrLabel.text = data[@"url"];
        
        NSLog(@"123");
    } fail:^(NSError *error) {
        
    } andViewController:self];
}
- (void)creatUI {
    self.headImage = [[UIImageView alloc]init];
    [self.view addSubview:self.headImage];
    [self.headImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview.bottom).offset(HeightScale(24));
        make.centerX.equalTo(0);
        make.height.with.width.equalTo(HeightScale(105));
    }];
    _headImage.layer.cornerRadius = HeightScale(105/2.0);
    _headImage.clipsToBounds = YES;
    
    
    self.nickNameLabel = [UILabel creatLabelWithFont:18 andbgcolor:nil andtextColor:SF_COLOR(0, 0, 0) andAligment:NSTextAlignmentCenter];
//    _nickNameLabel.text = @"其透气啊";
    [self.view addSubview:self.nickNameLabel];
    
    [self.nickNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImage.bottom).offset(HeightScale(10));
        make.centerX.equalTo(0);
    }];
    
    self.idLabel = [UILabel creatLabelWithFont:14 andbgcolor:nil andtextColor:SF_COLOR(124, 124, 124) andAligment:NSTextAlignmentCenter];
    self.idLabel.text = @"ID:1231";
    [self.view addSubview:self.idLabel];
    
    [self.idLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.top).offset(HeightScale(26));
        make.centerX.equalTo(0);
    }];
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"链接背景"]];
    [self.view addSubview:imageview];
    
    [imageview makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(WidthScale(315));
        make.centerX.equalTo(0);
        make.top.equalTo(self.idLabel.bottom).equalTo(HeightScale(68));
        make.height.equalTo(HeightScale(50));
    }];
    imageview.userInteractionEnabled = YES;
    
    ulrLabel = [UILabel creatLabelWithFont:17 andbgcolor:nil andtextColor:SF_COLOR(28, 108, 229) andAligment:NSTextAlignmentCenter];
    ulrLabel.text = @"www.baidu,com";
    [imageview addSubview:ulrLabel];
    
    [ulrLabel makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    ulrLabel.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pasteGes:)];
    longGes.minimumPressDuration = 1;
    [ulrLabel addGestureRecognizer:longGes];
    
    UILabel *textlabel = [UILabel creatLabelWithFont:14 andbgcolor:nil andtextColor:SF_COLOR(124, 124, 124) andAligment:0];
    NSString *str = @"1.长按可复制收徒链接;\n2.将该链接贴至任何你想发布的地方（例如：贴吧，论坛），用户通过手机访问该链接成功注册为开玩用户后，即可成为你的徒弟";
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5];
    [mstr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
    textlabel.numberOfLines = 0;
    [self.view addSubview:textlabel];
    textlabel.attributedText = mstr;
    textlabel.lineBreakMode = NSLineBreakByCharWrapping;
    [textlabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageview.bottom).offset(HeightScale(36));
        make.centerX.equalTo(0);
        make.width.equalTo([UIView setWidth:375-60]);
    }];
    [textlabel sizeToFit];
    
    UIButton *btn = [UIButton creatButtonWithTitle:@"分享好友收徒" andBgColor:SF_COLOR(28, 108, 229) andTextColor:SF_COLOR(255, 255, 255) andtitleFont:23];
    [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.layer.cornerRadius = 10;
    btn.clipsToBounds = YES;
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textlabel.bottom).offset([UIView setHeight:105]);
        make.width.equalTo([UIView setWidth:294]);
        make.centerX.equalTo(0);
        make.height.equalTo([UIView setHeight:44]);
    }];
}
- (void)shareClick:(UIButton *)btn {
    [UMSocialUIManager setPreDefinePlatforms:@[@(4),@(5)]];
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

- (void)pasteGes:(UILongPressGestureRecognizer *)longGes {
    if (longGes.state == UIGestureRecognizerStateBegan) {
        
        UIPasteboard *past = [UIPasteboard generalPasteboard];
        past.string = @"baidu.com";
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.mode = MBProgressHUDModeText;
        hub.label.text = @"复制成功";

        hub.offset = CGPointMake(0.f, 0);
        [hub hideAnimated:YES afterDelay:2.f];
    }
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
