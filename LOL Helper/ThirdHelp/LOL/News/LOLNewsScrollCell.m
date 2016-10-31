//
//  LOLNewsScrollCell.m
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLNewsScrollCell.h"
#import "JPLoopView.h"
#import "LOLNewsScrollCellModel.h"

@interface LOLNewsScrollCell ()<JPLoopViewDelegate,JPLoopViewDataSource>

@end

@implementation LOLNewsScrollCell
{
    NSMutableArray *_urls;
    JPLoopView *_loopView;
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
    _loopView = [[JPLoopView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width*IMAGE_SCALE)];
    _loopView.dataSource = self;
    _loopView.delegate = self;
    [self.contentView addSubview:_loopView];
    _urls = [NSMutableArray array];
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray{
    _imageUrlArray = imageUrlArray;
    if (imageUrlArray.count) {
        [_urls removeAllObjects];
        for (LOLNewsScrollCellModel *model in imageUrlArray) {
            NSString *imageUrl = model.image_url_big;
            [_urls addObject:imageUrl];
        }
    }
    [_loopView jp_reloadData];
}

#pragma mark - 必须实现的代理
- (NSArray *)loopViewUrls:(JPLoopView *)loopView{
    
    return _urls;
}

- (void)didSelectItem:(JPLoopView *)loopView index:(NSInteger)index{
    
    if ([self.delegate respondsToSelector:@selector(didSelectItem:index:)]) {
        [self.delegate didSelectItem:self index:index];
    }
}

@end
