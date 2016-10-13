//
//  LOL_Request.h
//  LOL Helper
//
//  Created by tztddong on 16/10/9.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#ifndef LOL_Request_h
#define LOL_Request_h

//轮播图
#define LOL_URL_SCROLLIMAGE @"http://qt.qq.com/static/pages/news/phone/c13_list_1.shtml"
//资讯列表
#define LOL_URL_NEWSLIST  @"http://qt.qq.com/php_cgi/news/php/varcache_getnews.php"
//html的BaseUrl
#define LOL_HTML_BASEURL @"http://qt.qq.com/static/pages/news/phone/"
//组头分类
#define LOL_CLASS @"http://qt.qq.com/php_cgi/news/php/varcache_channel.php?plat=ios&version=2"
//收藏
#define LOL_COLLET @"http://qt.qq.com/php_cgi/news/php/getsavenews.php?next_start_timestamp=0&plat=ios&version=3"
//拼接轮播URL
#define LOL_SCROLLURL(x)  @"http://qt.qq.com/static/pages/news/phone/x?APP_BROWSER_VERSION_CODE=1&ios_version=1005&imgmode=auto"
#endif /* LOL_Request_h */
