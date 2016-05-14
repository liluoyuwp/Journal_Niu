//
//  WeiboViewController.m
//  Journal_Niu
//
//  Created by WP on 16/4/18.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "WeiboViewController.h"
#import "UMSocial.h"
#import "UIImage+GIF.h"

@interface WeiboViewController ()<UMSocialUIDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ddd;

@end

@implementation WeiboViewController

- (IBAction)分享:(id)sender {
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMSOCIAL_KEY
                                      shareText:@"黎洛羽"
                                     shareImage:[UIImage sd_animatedGIFNamed:@"aaaaaaaaa"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
                                       delegate:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ddd.image = [UIImage sd_animatedGIFNamed:@"aaaaaaaaa"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
