//
//  OnePieceViewController.m
//  KaiWan 
//
//  Created by van7ish on 2017/4/27.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "OnePieceViewController.h"

@interface OnePieceViewController ()

{
    AppDelegate * _delegate;
}

@property (nonatomic, strong) UIWebView * webView;

@end

@implementation OnePieceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"一元夺宝";
    [self setNavigationBar];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://y1.api.ikaiwan.com/newkaiwan.php?uid=%@", _delegate.uid]]]];
    [self.view addSubview:_webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
