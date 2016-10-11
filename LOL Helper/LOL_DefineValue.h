//
//  LOL_DefineValue.h
//  LOL Helper
//
//  Created by tztddong on 16/10/9.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#ifndef LOL_DefineValue_h
#define LOL_DefineValue_h

#define FONTSIZE(x)  [UIFont systemFontOfSize:x]//设置字体大小
#define KWIDTH  [UIScreen mainScreen].bounds.size.width//屏幕的宽
#define KHEIGHT [UIScreen mainScreen].bounds.size.height//屏幕的高
#define KMARGIN 10//默认间距
#define KNAVHEIGHT 64 //导航栏的高度
#define KTABBARHEIGHT 49 //底部tabbar高度
#define TEXTSIZEWITHFONT(text,font) [text sizeWithAttributes:[NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName]]//根据文本及其字号返回size
#define ScaleValueH(valueh) ((valueh)*667.0f/[UIScreen mainScreen].bounds.size.height)
#define ScaleValueW(valuew) ((valuew)*375.0f/[UIScreen mainScreen].bounds.size.width)
#define WEAK_SELF(value) __weak typeof(self) value = self
#define LOL_NotificationCenter [NSNotificationCenter defaultCenter]
//高效打印
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行  %@\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif
//默认金色
#define DefaultGodColor RGBColor(174, 136, 68)
//图片比例
#define IMAGE_SCALE 250.0/520.0
#endif /* LOL_DefineValue_h */
