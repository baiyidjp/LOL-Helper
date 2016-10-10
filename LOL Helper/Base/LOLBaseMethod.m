//
//  LOLBaseMethod.m
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLBaseMethod.h"

@implementation LOLBaseMethod

/*
 根据文字字号获取 lab 的高度
 */
+(CGFloat)LabelHeightofString:(NSString *)str withFont:(UIFont *)font withWidth:(CGFloat)width
{
    if ([str isKindOfClass:[NSString class]]) {
        NSDictionary *attributes = @{NSFontAttributeName: font};
        CGRect rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.height;
    }
    return 0;
}
/**
 * 根据文字的字号,获取 lab 的宽度
 */
+(CGFloat)LabelWidthOfString:(NSString *)str withFont:(UIFont *)font withHeight:(CGFloat)height
{
    if ([str isKindOfClass:[NSString class]]) {
        NSDictionary *attributes = @{NSFontAttributeName: font};
        CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, height)options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.width;
    }
    return 0;
}


@end
