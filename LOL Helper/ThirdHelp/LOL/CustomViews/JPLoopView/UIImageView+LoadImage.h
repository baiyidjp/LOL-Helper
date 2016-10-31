//
//  UIImageView+LoadImage.h
//  JPLoopViewDemo
//
//  Created by tztddong on 2016/10/31.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LoadImage)

//* 模仿SDWebImage的图片下载 */
- (void)jp_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

@end
