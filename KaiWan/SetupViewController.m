//
//  SetupViewController.m
//  KaiWan
//
//  Created by chenguang on 17/4/5.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "SetupViewController.h"

@interface SetupViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView *headimage;
@property (nonatomic,strong) UITextField *nicknameTx;
@property (nonatomic,strong) UITextField *idTx;
@property (nonatomic,strong) UITextField *WcTx;
@property (nonatomic,strong) UITextField *phoneTx;
@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"个人资料";
    [self setNavigationBar];
    [self setupUI];
    [self reuqest];
}
- (void)reuqest {
    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,_dataDic[@"avatar"]]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    self.idTx.text = [self.dataDic[@"id"] stringValue];
    self.nicknameTx.text = self.dataDic[@"nickname"];
    if (self.dataDic[@"openid"]) {
        self.WcTx.text = @"已绑定微信";
    }else {
        self.WcTx.text = @"未绑定微信";
    }
    self.phoneTx.text = self.dataDic[@"phone"];
}
- (void)setupUI {
    UIView *bview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, [UIView setHeight:335])];
    bview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bview];
    
    UILabel *tlabel = [[UILabel alloc]init];
    tlabel.text = @"头像";
    tlabel.textColor = SF_COLOR(51, 51, 51);
    tlabel.font = [UIFont systemFontOfSize:15];
    [bview addSubview:tlabel];
    
    self.headimage = [[UIImageView alloc]init];
    self.headimage.layer.cornerRadius = [UIView setWidth:30];
    self.headimage.clipsToBounds = YES;
    self.headimage.layer.borderColor = SF_COLOR(170, 204, 255).CGColor;
    self.headimage.backgroundColor = [UIColor redColor];
    self.headimage.layer.borderWidth = 1;
    self.headimage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headtapClick)];
    [self.headimage addGestureRecognizer:tap];
    [bview addSubview:self.headimage];
    
    
    UIImageView *image1 = [[UIImageView alloc]init];
    image1.image = [UIImage imageNamed:@"个人中心-箭头"];
    [bview addSubview:image1];
    
    UILabel *linelabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIView setHeight:84], SWIDTH, [UIView setHeight:1])];
    linelabel1.backgroundColor = SF_COLOR(232, 232, 232);
    [bview addSubview:linelabel1];
    [tlabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.height.equalTo([UIView setHeight:85]);
        make.left.equalTo([UIView setWidth:12]);
    }];
    
    [image1 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-[UIView setWidth:12]);
        make.centerY.equalTo(tlabel.centerY);
        make.width.and.height.equalTo([UIView setWidth:20]);
    }];
    [self.headimage makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(image1.left);
        make.centerY.equalTo(tlabel);
        make.height.and.width.equalTo([UIView setWidth:60]);
    }];
    
    
    NSArray *titleArr = @[@"昵称",@"ID",@"微信",@"手机号"];
    NSArray *arr = @[@"0",@"0",@"0",@"0"];
    for (int i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.text = titleArr[i];
        label.textColor = SF_COLOR(51, 51, 51);
        label.font = [UIFont systemFontOfSize:15];
        [bview addSubview:label];
        
        
        UITextField *textf = [[UITextField alloc]init];
        textf.textAlignment = NSTextAlignmentRight;
        textf.textColor = SF_COLOR(102, 102, 102);
        textf.font = [UIFont systemFontOfSize:13];
        [bview addSubview:textf];
        textf.tag = 450+i;
        textf.text = arr[i];
        textf.delegate = self;
        
        UILabel *linelabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIView setHeight:84+(i+1)*50], SWIDTH, [UIView setHeight:1])];
        linelabel1.backgroundColor = SF_COLOR(232, 232, 232);
        [bview addSubview:linelabel1];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo([UIView setHeight:50*i+85]);
            make.height.equalTo([UIView setHeight:50]);
            make.left.equalTo([UIView setWidth:12]);
            
        }];
        [textf makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label.centerY);
            make.right.equalTo(-[UIView setWidth:18]);
            make.height.equalTo([UIView setHeight:50]);
            make.width.equalTo([UIView setWidth:200]);
        }];
       
        switch (i) {
            case 0:
                self.nicknameTx = textf;
                break;
            case 1:
                self.idTx = textf;
                break;
            case 2:
                self.WcTx = textf;
                break;
            case 3:
                self.phoneTx = textf;
                break;
                
            default:
                break;
        }
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag>450) {
        return NO;
    }
    return YES;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.headimage.image = newPhoto;
    
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

    NSDictionary *dic = @{@"avatar":[self imageBase64WithDataURL:newPhoto]};
    [RequestData PostDataWithURL:[NSString stringWithFormat:@"%@User/set.html?uid=%@",HostUrl,del.uid] parameters:dic sucsess:^(id response) {
    } fail:^(NSError *error) {
    } andViewController:self];
    

    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSString *)imageBase64WithDataURL:(UIImage *)image
{
    NSData *imageData =nil;
    NSString *mimeType =nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x =100 / image.size.height;
    if (x >1)
    {
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(image, x);
    mimeType = @"image/png";
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions:0]];
}

- (void)headtapClick {
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
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
