//
//  AppDelegateTool.m
//  Journal_Niu
//
//  Created by WP on 16/5/3.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "AppTool.h"
#import "UMSocial.h"
#import "Config.h"
#import "CustomURLCache.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWhatsappHandler.h"
#import "UMSocialTumblrHandler.h"
#import "UMSocialLineHandler.h"
#import "YLAPI.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>

@interface AppTool ()<UMSocialUIDelegate>

@end

@implementation AppTool

#pragma maek - 友盟相关
+ (void)initializeUMSocial {
    [UMSocialData setAppKey:UMSOCIAL_KEY];
    
    //打开调试log的开关
    //[UMSocialData openLog:YES];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wx20c32ca782ff8e3f" appSecret:@"718890edb2550ece21bc5a90bca3dc12" url:@"http://weixin.qq.com"];
    
    // 打开新浪微博的SSO开关
    // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"276476390"
                                              secret:@"a3f42e829212bfac63fc2ee6a51ef0f9"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //设置分享到QQ空间的应用Id，和分享url链接
    [UMSocialQQHandler setQQWithAppId:@"1105339695" appKey:@"gNgzAL7MaVmh74ai" url:@"http://ui.ptlogin2.qq.com/cgi-bin/login?style=9&pt_ttype=1&appid=549000929&pt_no_auth=1&daid=5&s_url=https%3A%2F%2Fh5.qzone.qq.com%2Fmqzone%2Findex"];
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
}

+ (BOOL)delegateToolOpenURL:(NSURL *)url {
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

+ (void)delegateToolDidBecomeActive {
    [UMSocialSnsService  applicationDidBecomeActive];
}

+ (void)shareInViewController:(UIViewController *)vc
                         text:(NSString *)text
                        image:(UIImage *)image
                     detailID:(NSString *)detail_id {
    
    [UMSocialSnsService presentSnsIconSheetView:vc
                                         appKey:UMSOCIAL_KEY
                                      shareText:text
                                     shareImage:image
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina]
                                       delegate:(id)self];
    
    if (!detail_id) return;
    NSString *strUrl = [NSString stringWithFormat:YILIN_INFORMATION_URL,detail_id];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = strUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = strUrl;
    [UMSocialData defaultData].extConfig.qqData.url = strUrl;
    [UMSocialData defaultData].extConfig.qzoneData.url = strUrl;
}

#pragma mark - 蒲公英
+ (void)initializePugongying {
    //启动基本SDK
    [[PgyManager sharedPgyManager] startManagerWithAppId:PGY_APP_ID];
    //启动更新检查SDK
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:PGY_APP_ID];
    //关闭用户反馈功能
    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
}

/// 检查更新
+ (void)checkUpdateVersion {
    [[PgyUpdateManager sharedPgyManager] checkUpdate];
}

#pragma mark - public method
+ (void)initializeCache {
    CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                 diskCapacity:200 * 1024 * 1024
                                                                     diskPath:nil
                                                                    cacheTime:0];
    [CustomURLCache setSharedURLCache:urlCache];
}

@end
