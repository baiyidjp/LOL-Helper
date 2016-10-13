//
//  LOLNewsClassModel.h
//  LOL Helper
//
//  Created by tztddong on 16/10/11.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LOLNewsClassModel : NSObject

@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *is_entry;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *intent;
@property(nonatomic,copy)NSString *showhot;
@property(nonatomic,copy)NSString *shownew;
@property(nonatomic,copy)NSString *bgcolor;

/*
 "id": "73",
 "name": "赛事",
 "specil": "0",
 "url": "",
 "is_entry": "1",
 "subtitle": "2016全球总决赛",
 "img": "http://ossweb-img.qq.com/upload/qqtalk/news/201609/071753475693864.png",
 "intent": "",
 "showhot": "0",
 "shownew": "1",
 "bgcolor": "#00bfc8"
 */

/*
 "id": "23",
 "name": "活动",
 "specil": "0",
 "url": " ",
 "is_entry": "0",
 "subtitle": "",
 "img": "",
 "intent": "",
 "showhot": "1",
 "shownew": "0",
 "bgcolor": ""
 */
@end
