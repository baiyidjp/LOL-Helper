//
//  BaseViewController.m
//  WeChat_D
//
//  Created by tztddong on 16/7/8.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLBaseViewController.h"

@interface LOLBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation LOLBaseViewController

/**
 *  修改状态栏字体颜色成白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"888888"];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
@end
