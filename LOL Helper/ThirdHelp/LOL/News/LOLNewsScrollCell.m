//
//  LOLNewsScrollCell.m
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLNewsScrollCell.h"
#import "ImageScrollView.h"

@implementation LOLNewsScrollCell
{
    ImageScrollView *_scrollView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
    }
    return self;
}

#pragma mark - 配置View
- (void)configViews
{
    _scrollView = [ImageScrollView returnImageScrollViewWithFrame:CGRectMake(0, 0, KWIDTH, KWIDTH*IMAGE_SCALE) imageUrl:nil];
    [self.contentView addSubview:_scrollView];
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray
{
    _imageUrlArray = imageUrlArray;
    _scrollView.imageUpdateUrls = imageUrlArray;
}

@end
