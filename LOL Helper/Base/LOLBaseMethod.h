//
//  LOLBaseMethod.h
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LOLBaseMethod : NSObject

/**
    根据文字字号获取lab高度
 */
+ (CGFloat)LabelHeightofString:(NSString *)str
                     withFont:(UIFont *)font
                    withWidth:(CGFloat)width;
/**
    根据文字字号获取lab宽度
 */
+ (CGFloat)LabelWidthOfString:(NSString *)str
                    withFont:(UIFont *)font
                  withHeight:(CGFloat)height;

/** 根据字符串日期转换成格式化时间 X分钟/小时... */
+ (NSString *)timeWithDate:(NSString *)stringDate;

@end
