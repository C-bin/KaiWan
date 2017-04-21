//
//  HighTaskWebViewController.m
//  KaiWan
//
//  Created by van7ish on 2017/4/19.
//  Copyright © 2017年 chenguang. All rights reserved.
//

#import "HighTaskWebViewController.h"

@interface HighTaskWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;

@end

@implementation HighTaskWebViewController

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64)];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.taskDic[@"open_url"]]]];
        _webView.delegate = self;
    }
    return _webView;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titlestring = @"开始任务";
    [self setNavigationBar];
    
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UIWebViewDelegate Method
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    DLog(@"webView加载完成");
}


@end
