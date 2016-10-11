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

- (void)didSelectNoamalClassBtnWithView:(LOLNewsNormalClassView *)noamalClassView classModel:(LOLNewsClassModel *)classModel;

@end

@interface LOLNewsNormalClassView : UIView<UIScrollViewDelegate>

/** models */
@property(nonatomic,strong)NSArray  *classModels;
/** id */
@property(nonatomic,strong)NSString *classID;

@property(nonatomic,weak)id<LOLNewsNormalClassViewDeleagte> delegate;

@end
