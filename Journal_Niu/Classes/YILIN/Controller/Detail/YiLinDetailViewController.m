//
//  YiLinDetailViewController.h
//  Journal_Niu
//
//  Created by WP on 16/4/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "YiLinDetailViewController.h"
#import "CustomURLCache.h"

@interface YiLinDetailViewController ()<UIWebViewDelegate>

@end

@implementation YiLinDetailViewController
{
    __weak IBOutlet UIWebView *_webView;
    NSMutableURLRequest *_request;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initCache];

    [self initUI];

    [self showHUD];

    [self updateData];
    
//    [self addWebViewRefresh];
}

- (void)initCache {
    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    urlCache.isCache = YES;
}

- (void)initUI {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"＜返回" style:UIBarButtonItemStyleDone target:self action:@selector(barButtonPopBack)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)barButtonPopBack {
    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    urlCache.isCache = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateData {
    NSString *urlString = [NSString stringWithFormat:YILIN_INFORMATION_URL,self.yiLinDetail_id];
    _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    _request.timeoutInterval = REQUEST_TIME;
    _request = [_request copy];
    [_webView loadRequest:_request];
}

- (void)addWebViewRefresh {
    _webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
        [urlCache removeCachedResponseForRequest:_webView.request];
        [_webView loadRequest:_request];
    }];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_webView.scrollView.mj_header endRefreshing];
    [self hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_webView.scrollView.mj_header endRefreshing];
    [self hideHUD];
    NSLog(@"%@",error);
}

@end
