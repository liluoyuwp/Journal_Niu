//
//  YiLinDetailViewController.h
//  Journal_Niu
//
//  Created by WP on 16/4/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "YiLinDetailViewController.h"
#import "CustomURLCache.h"
#import "AppTool.h"

@interface YiLinDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;

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
    
    [self updateShoucangBtn];
}

- (void)initCache {
    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    urlCache.isCache = YES;
}

- (void)initUI {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"＜" style:UIBarButtonItemStyleDone target:self action:@selector(barButtonPopBack)];
    self.navigationItem.title = @"意林";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(barButtonShare)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)updateData {
    NSString *urlString = [NSString stringWithFormat:YILIN_INFORMATION_URL,self.yiLinDetail_id];
    _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    _request.timeoutInterval = REQUEST_TIME;
    _request = [_request copy];
    [_webView loadRequest:_request];
}

- (void)updateShoucangBtn {
    id obj = [self.cdManager searchShoucangModelInDBWithtype:@"shoucang_yilin" shoucang_id:_yiLinDetail_id];
    if (![obj isKindOfClass:[NSString class]]) {
        self.shoucangBtn.selected = YES;
    }
}

#pragma mark - 收藏按钮
- (IBAction)shoucangBtnClick:(UIButton *)sender {
    WS(weakSelf);
    if (sender.selected) {
        [WPAlertView showAlertWithMessage:@"确认取消收藏?" sureKey:^{
            [weakSelf.cdManager deleteShoucangModelWithWithtype:@"shoucang_yilin" shoucang_id:_yiLinDetail_id];
            sender.selected = NO;
        } cancelKey:nil];
    } else {
        [self.cdManager insertShoucangModelInDB:self.model];
        sender.selected = YES;
    }
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

#pragma mark - bar button actions.
- (void)barButtonShare {
    
    [AppTool shareInViewController:self
                              text:_text
                             image:_image
                          detailID:_yiLinDetail_id];
}

- (void)barButtonPopBack {
    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    urlCache.isCache = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
