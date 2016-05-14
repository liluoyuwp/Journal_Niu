//
//  AppDelegateTool.h
//  Journal_Niu
//
//  Created by WP on 16/5/3.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDelegateTool : NSObject

/// 初始化友盟分享管理类.
+ (void)initializeUMSocial;

/// 初始化webView缓存类.
+ (void)initializeCache;

/// 友盟分享,这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来.
+ (BOOL)delegateToolOpenURL:(NSURL *)url;

/// 友盟分享,这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用.
+ (void)delegateToolDidBecomeActive;

@end
