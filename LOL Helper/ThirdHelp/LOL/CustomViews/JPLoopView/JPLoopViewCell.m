//
//  JPLoopViewCell.m
//  JPLoopViewDemo
//
//  Created by tztddong on 2016/10/31.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "JPLoopViewCell.h"
#import "UIImageView+LoadImage.h"

@implementation JPLoopViewCell
{
    UIImageView *_imageView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)setUrl:(NSString *)url{
    
    _url = url;
    //如项目中用到成熟的第三方:SDWebImage 等 可替换
    [_imageView jp_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
}

@end
