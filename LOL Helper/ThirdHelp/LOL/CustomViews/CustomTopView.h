//
//  CustomTopView.h
//  MeiKeLaMei
//
//  Created by tztddong on 16/6/13.
//  Copyright © 2016年 gyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTopView : UIView
/**
 *
 *  @param title        标题
 *  @param ctrl         当前控制器
 *  @param isHiddenBack 是否隐藏返回按钮
 *
 *  @return 导航栏
 */
+ (CustomTopView *)returnCustomTopViewWithTitle:(NSString *)title controller:(UIViewController *)ctrl isHiddenBack:(BOOL)isHiddenBack;

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)UIViewController *ctrl;
@property(nonatomic,assign)BOOL isHiddenBack;
/**
 *  改变标题
 */
@property(nonatomic,strong)NSString *updateTitle;
@end
