//
//  AppDelegateTool.m
//  Journal_Niu
//
//  Created by WP on 16/5/3.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "AppDelegateTool.h"
#import "UMSocial.h"
#import "Config.h"
#import "CustomURLCache.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialQQHandler.h"

@implementation AppDelegateTool

+ (void)initializeUMSocial {
    [UMSocialData setAppKey:UMSOCIAL_KEY];
    
    //打开调试log的开关
    //[UMSocialData openLog:YES];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxdc1e388c3822c80b" appSecret:@"a393c1527aaccb95f3a4c88d6d1455f6" url:@"http://www.umeng.com/social"];
    
    // 打开新浪微博的SSO开关
    // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //设置分享到QQ空间的应用Id，和分享url链接
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
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

+ (void)initializeCache {
    CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                 diskCapacity:200 * 1024 * 1024
                                                                     diskPath:nil
                                                                    cacheTime:0];
    [CustomURLCache setSharedURLCache:urlCache];
}

@end
