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

/// 获得 主线程
#define d1ispatch_async_get_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

/// RGB
#define COLOR(R, G, B, A) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(A)]

/// 16进制颜色
#define ColorFromRGA(rgbValue,A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(A)]

/// 请求时间
#define REQUEST_TIME 300.0f

/// 友盟分享AppKey
#define UMSOCIAL_KEY @"5732a1d8e0f55a5c95002bf5"


// 意林 最新
#define YILIN_ZUIXIN @"yilin_zuixin"

// 意林 心灵鸡汤
#define YILIN_XINLING @"yilin_xinling"

// 意林 视界
#define YILIN_SHIJIE @"yilin_shijie"

// 意林 成长
#define YILIN_CHENGZHANG @"yilin_chengzhang"

// 意林 文艺志
#define YILIN_WEIYIZHI @"yilin_wenyizhi"

// 意林 乐活
#define YILIN_LEHUO @"yilin_lehuo"

// 诗画话 搞笑秀
#define SHIHUAHUA_LAUGH @"shihuahua_laugh"

// 诗画话 微阅读
#define SHIHUAHUA_READ @"shihuahua_read"

// 指谈会 首页
#define ZHITANHUI_SHOUYE @"zhitanhui_shouye"

// 指谈会 跟帖
#define ZHITANHUI_GENTIE @"zhitanhui_gentie"

// 指谈会 往期
#define ZHITANHUI_WANGQI @"zhitanhui_wangqi"





















#endif
