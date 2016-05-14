//
//  Config.h
//
//
//  Created by WP on 16-04-18.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#ifndef WP_Config
#define WP_Config

/// 屏宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/// 屏高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/// 导航条高度.
#define NAVBAR_HEIGHT 64

/// tabbar高度.
#define TABBAR_HEIGHT 49

/// weak block typeof.
#define WS(weakSelf)  __weak __block __typeof(&*self)weakSelf = self;   //!< WS(weakSelf) self in block.

/// RGB
#define COLOR(R, G, B, A) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(A)]

/// 16进制颜色
#define ColorFromRGA(rgbValue,A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(A)]

/// 请求时间
#define REQUEST_TIME 300.0f

/// 友盟分享AppKey
#define UMSOCIAL_KEY @"5732a1d8e0f55a5c95002bf5"























#endif
