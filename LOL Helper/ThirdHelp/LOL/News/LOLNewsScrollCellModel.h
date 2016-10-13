//
//  LOLNewsScrollCellModel.h
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LOLNewsScrollCellModel : NSObject

@property(nonatomic,copy)NSString *image_url_big;
@property(nonatomic,copy)NSString *article_url;
@property(nonatomic,copy)NSString *title;

/*
 "channel_id": "&lt;2&gt;:&lt;13&gt;,&lt;2&gt;:&lt;169&gt;,&lt;2&gt;:&lt;229&gt;",
 "channel_desc": "推荐",
 "article_id": "23118",
 "content_id": "23118",
 "insert_date": "2016-09-21 15:45:37",
 "publication_date": "2016-09-30 14:35:16",
 "is_direct": "False",
 "is_top": "True",
 "article_url": "18/article_23118.shtml",
 "title": "2016全球总决赛赛事预告及回顾",
 "image_url_small": "http://ossweb-img.qq.com/upload/qqtalk/news/201610/100621295901238_282.jpg",
 "image_url_big": "http://ossweb-img.qq.com/upload/qqtalk/news/201610/100621295901238_480.jpg",
 "image_spec": "1",
 "image_with_btn": "False",
 "score": "3",
 "summary": "16支全球顶级战队，将为职业赛事最高荣耀发起最后的冲击。",
 "targetid": "1548574607",
 "is_act": "0",
 "is_hot": "0",
 "is_subject": "0",
 "is_report": "True",
 "is_new": "0"
 */

@end
