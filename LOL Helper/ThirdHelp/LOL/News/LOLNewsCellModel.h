//
//  LOLNewsCellModel.h
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LOLNewsCellModel : NSObject

//标题
@property(nonatomic,copy)NSString *title;
//URL地址
@property(nonatomic,copy)NSString *article_url;
//简介
@property(nonatomic,copy)NSString *summary;
//图片地址
@property(nonatomic,copy)NSString *image_url_small;
//阅读量
@property(nonatomic,copy)NSString *pv;
//最新时间
@property(nonatomic,copy)NSString *publication_date;
//新闻类别 默认是空 (专题 视频 图集 战报 俱乐部)
@property(nonatomic,copy)NSString *newstype;
//新闻类型 默认是 ordinary  (image report club)
@property(nonatomic,copy)NSString *newstypeid;
//是否置顶
@property(nonatomic,copy)NSString *is_top;
//战报相关
@property(nonatomic,copy)NSString *teama_name;
@property(nonatomic,copy)NSString *teamb_name;
@property(nonatomic,copy)NSString *march_result;
@property(nonatomic,copy)NSString *teama_logo;
@property(nonatomic,copy)NSString *teamb_logo;
//图集相关
@property(nonatomic,copy)NSString *big_image_url;
@property(nonatomic,copy)NSString *small_image_url;
@property(nonatomic,copy)NSString *count_image_url;
/** 图个数 */
@property(nonatomic,copy)NSString *count;
/*
 "article_id": "23818",
 "content_id": "23818",
 "newstype": "",
 "newstypeid": "ordinary",
 "channel_desc": "",
 "channel_id": "<2>:<12>,<2>:<18>,<2>:<232>,<2>:<232>:<234>,<2>:<32>",
 "insert_date": "2016-10-09 17:22:39",
 "title": "每日一笑：太倒霉了",
 "article_url": "http://qt.qq.com/static/pages/news/phone/18/article_23818.shtml",
 "summary": "倒霉得毫无反抗力。",
 "score": "3",
 "publication_date": "2016-10-09 17:13:43",
 "targetid": "1569886881",
 "intent": "",
 "is_act": "0",
 "is_hot": "0",
 "is_subject": "0",
 "is_new": "0",
 "is_top": "False",
 "image_with_btn": "False",
 "image_spec": "1",
 "is_report": "True",
 "is_direct": "False",
 "image_url_small": "http://ossweb-img.qq.com/upload/qqtalk/news/201610/091722398887776_282.jpg",
 "image_url_big": "http://ossweb-img.qq.com/upload/qqtalk/news/201610/091722398887776_480.jpg",
 "pv": "3778093",
 "bmatchid": "0",
 "v_len": "",
 "pics_id": "0"
 战报
 "match_date": "2016-10-10 08:00:00",
 "match_name": "2016全球总决赛",
 "teama_name": "IM",
 "teamb_name": "C9",
 "march_result": "0:1",
 "teama_logo": "http://shp.qpic.cn/lolwebvideo/201501/b46891d51c3cf54d795ee968b519cf94/0",
 "teamb_logo": "http://shp.qpic.cn/lolwebvideo/201501/708dee8948c5b153c839bef384953bda/0"
 图片
 "pics_id": "92",
 "big_image_url": "http://ossweb-img.qq.com/upload/qqtalk/news/201610/101723139849621_480.jpg",
 "big_index": "0",
 "count": "8",
 "small_image_url": "http://ossweb-img.qq.com/upload/qqtalk/news/201610/101723139858_480.jpg",
 "small_index": "0",
 "count_image_url": "http://ossweb-img.qq.com/upload/qqtalk/news/201610/101723139853831_480.jpg",
 "imageset_id": "92"
 */

@end
