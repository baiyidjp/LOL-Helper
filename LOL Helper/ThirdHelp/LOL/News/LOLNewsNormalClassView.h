//
//  LOLNewsNormalClassView.h
//  LOL Helper
//
//  Created by tztddong on 16/10/11.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LOLNewsNormalClassView,LOLNewsClassModel;
@protocol LOLNewsNormalClassViewDeleagte <NSObject>

- (void)didSelectNoamalClassBtnWithView:(LOLNewsNormalClassView *)noamalClassView classModel:(LOLNewsClassModel *)classModel index:(NSInteger)index type:(NSInteger)type;

@end

@interface LOLNewsNormalClassView : UIView<UIScrollViewDelegate>

/** models */
@property(nonatomic,strong)NSArray  *classModels;
/** id */
@property(nonatomic,strong)NSString *classID;

@property(nonatomic,weak)id<LOLNewsNormalClassViewDeleagte> delegate;

- (instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type; //1代表固定的 2代表header

- (void)scrollToItemIndex:(NSInteger)index;

@end
