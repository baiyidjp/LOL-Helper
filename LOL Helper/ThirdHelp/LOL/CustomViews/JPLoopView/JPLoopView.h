//
//  JPLoopView.h
//  JPLoopViewDemo
//
//  Created by tztddong on 2016/10/31.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPLoopView;
@protocol JPLoopViewDataSource <NSObject>

@required
//* 必传的数据 图片的URL集合 */
- (NSArray *)loopViewUrls:(JPLoopView *)loopView;

@optional
//* 选择实现的数据源 滚动视图和分页view 在 loopView 上的frame */
- (CGRect)scrollViewFrame:(JPLoopView *)loopView;
- (CGRect)pageControlFrame:(JPLoopView *)loopView;
//* 是否隐藏分页 */
- (BOOL)hiddenPageControl:(JPLoopView *)loopView;
@end

@protocol JPLoopViewDelegate <NSObject>

//* 点击图片的代理方法 */
- (void)didSelectItem:(JPLoopView *)loopView index:(NSInteger)index;

@end

@interface JPLoopView : UIView

@property(nonatomic,weak)id<JPLoopViewDataSource> dataSource;
@property(nonatomic,weak)id<JPLoopViewDelegate> delegate;

//* 刷新数据 */
- (void)jp_reloadData;

@end
