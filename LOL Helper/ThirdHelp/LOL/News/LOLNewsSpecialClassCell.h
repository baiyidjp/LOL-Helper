//
//  LOLNewsSpecialClassCell.h
//  LOL Helper
//
//  Created by tztddong on 16/10/11.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LOLNewsSpecialClassCell,LOLNewsClassModel;
@protocol LOLNewsSpecialClassCellDeleagte <NSObject>

- (void)didSelectSpecialClassBtnWithView:(LOLNewsSpecialClassCell *)specialClassView classModel:(LOLNewsClassModel *)classModel;

@end

@interface LOLNewsSpecialClassCell : UITableViewCell

/** model */
@property(nonatomic,strong)NSArray *classModels;

@property(nonatomic,weak)id<LOLNewsSpecialClassCellDeleagte> delegate;

@end
