//
//  YLAPI.h
//
//
//  Created by WP on 16-04-18.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#ifndef WP_YLAPI
#define WP_YLAPI

//最新
#define YILIN_NEWS_URL  @"http://yl.cms.palmtrends.com/api_v2.php?action=lastest_list&sa=news&offset=%ld&count=15&uid=10288928&platform=a"
//心灵鸡汤
#define YILIN_SOUP_URL   @"http://yl.cms.palmtrends.com/api_v2.php?action=list&sa=soup&offset=%ld&count=15&uid=10288928&platform=a"
//视界
#define YILIN_HORIZON_URL  @"http://yl.cms.palmtrends.com/api_v2.php?action=list&sa=horizon&offset=%ld&count=15&uid=10288928&platform=a"
//成长
#define YILIN_GROWUP_URL  @"http://yl.cms.palmtrends.com/api_v2.php?action=list&sa=growup&offset=%ld&count=15&uid=10288928&platform=a"
//文艺志
#define YILIN_ART_URL  @"http://yl.cms.palmtrends.com/api_v2.php?action=list&sa=art&offset=%ld&count=15&uid=10288928&platform=a"
//乐活
#define YILIN_LIFE_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=list&sa=life&offset=%ld&count=15&uid=10288928&platform=a"
//意林页进入详情
#define YILIN_INFORMATION_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=article&id=%@&fontsize=m&uid=10288928&e=86587cf27fc31a81ad14c8663854ab94&platform=a&pid=10048"
//#define YILIN_INFORMATION_URL  YILIN_BASE @"action=article&id=%d&fontsize=m&uid=10288928&e=86587cf27fc31a81ad14c8663854ab94&platform=a&pid=10048"

//消息
#define YILIN_COMMENT_URL  @"http://yl.cms.palmtrends.com/api_v2.php?action=commentlist&id=%d&offset=%d&count=15&uid=10288928&platform=a&mobile=MI-ONE+Plus&pid=10048&e=86587cf27fc31a81ad14c8663854ab94"

#define YILIN_COMMENT_SEND_URL  @"http://yl.cms.palmtrends.com/api_v2.php"

#define YILIN_ICON_URL @"http://yl.cms.palmtrends.com"

//视觉列表
#define KALEIDOSCOPE_SHIJUE_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=list&sa=sight&offset=%ld&count=8&uid=12862706"

//视觉详情
#define KALEIDOSCOPE_SHIJUE_DETAIL_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=picture&gid=%@&offset=0&count=100&uid=12862706"

//搞笑秀 可显示，搞笑秀
#define KALEIDOSCOPE_LAUGH_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=piclist&sa=laugh&offset=%ld&count=10&uid=10288928&platform=a"
//搞笑秀进入
#define KALEIDOSCOPE_LAUGH_INTO_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=picture&gid=%@&offset=0&count=100&uid=10288928&platform=a&mobile=MI-ONE+Plus&pid=10048&e=86587cf27fc31a81ad14c8663854ab94"

//微阅读 可显示/Users/ms/Library/Developer/Xcode
#define KALEIDOSCOPE_MICROREAD_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=list&sa=microread&offset=0&count=8&uid=10288928&platform=a"


//指谈会 可显示
#define PARTICPANCE_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=talk_what&type=1&sa=talk_home&offset=0&count=10&uid=10288928&platform=a"

//指谈会 往期
#define PARTICPANCE_TALK_WHAT_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=talk_what&type=2&sa=newtoq&offset=%ld&count=15&uid=10288928&platform=a"

//指谈会 跟帖
#define PARTICPANCE_COMMENTLIST_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=commentlist&id=%@&offset=%ld&count=15&ordertype=0&uid=10288928&platform=a"

//指谈会 跟帖 按顶贴数
#define PARTICPANCE_COMMENTLIST_TIE_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=commentlist&id=%@&offset=%d&count=15&ordertype=0&uid=10288928&platform=a"

//指谈会 跟帖 按时间
#define PARTICPANCE_COMMENTLIST_TIME_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=commentlist&id=%@&offset=%d&count=15&ordertype=1&uid=10288928&platform=a"

//跟帖 评论
#define PARTICPANCE_PINGLUN_URL @"http://yl.cms.palmtrends.com/api_v2.php?action=wzpl&offset=0&count=15&content=%@&id=%@&e=8e1a3ce94149f50df91a29b573933183&uid=10288928&pid=10048&mobile=iPhone8,1&platform=i"

//微博网页版
#define WEIBO_WEB_URL @"https://passport.weibo.cn/signin/login?entry=mweibo&res=wel&wm=5091_0026&r=http%3A%2F%2Fm.weibo.cn%2F%3Fwm%3D5091_0026"

#endif