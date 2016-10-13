//
//  LOLNewsScrollCell.m
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLNewsScrollCell.h"


@implementation LOLNewsScrollCell

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
    self.scrollView = [ImageScrollView returnImageScrollViewWithFrame:CGRectMake(0, 0, KWIDTH, KWIDTH*IMAGE_SCALE) imageUrl:nil];
    [self.contentView addSubview:_scrollView];
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray
{
    _imageUrlArray = imageUrlArray;
    self.scrollView.imageUpdateUrls = imageUrlArray;
}

@end
