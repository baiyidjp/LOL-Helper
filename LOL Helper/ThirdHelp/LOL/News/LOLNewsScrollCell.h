//
//  LOLNewsScrollCell.h
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"

@interface LOLNewsScrollCell : UITableViewCell

/** 集合 */
@property(nonatomic,strong)NSArray *imageUrlArray;

/** imageView */
@property(nonatomic,strong)ImageScrollView *scrollView;;

@end
