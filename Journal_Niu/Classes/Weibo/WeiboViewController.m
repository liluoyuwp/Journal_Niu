//
//  WeiboViewController.m
//  Journal_Niu
//
//  Created by WP on 16/4/18.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "WeiboViewController.h"

@interface WeiboViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    [self showHUD];
    
    [self refreshUI];
}

- (void)initUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"    " style:UIBarButtonItemStylePlain target:self action:@selector(webViewBack)];
}

- (void)refreshUI {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WEIBO_WEB_URL]]];
}

#pragma mark - UIWebViewDelegate 
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideHUD];
    [self showBackButtonOrNot];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    [self hideHUD];
    [self showBackButtonOrNot];
}

#pragma mark - bar button action
- (void)webViewBack {
    [self.webView goBack];
}

#pragma mark - methods
- (void)showBackButtonOrNot {
    if (self.webView.canGoBack) {
        self.navigationItem.leftBarButtonItem.title = @"＜";
        self.navigationItem.leftBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.leftBarButtonItem.title = @"";
        self.navigationItem.leftBarButtonItem.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
