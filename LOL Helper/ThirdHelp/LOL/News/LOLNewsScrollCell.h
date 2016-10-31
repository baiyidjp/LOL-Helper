//
//  LOLNewsScrollCell.h
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"

@class LOLNewsScrollCell;
@protocol LOLNewsScrollCellDelegate <NSObject>

- (void)didSelectItem:(LOLNewsScrollCell *)LOLNewsScrollCell index:(NSInteger)index;

@end

@interface LOLNewsScrollCell : UITableViewCell

/** 集合 */
@property(nonatomic,strong)NSArray *imageUrlArray;

@property(nonatomic,weak)id<LOLNewsScrollCellDelegate> delegate;

@end
