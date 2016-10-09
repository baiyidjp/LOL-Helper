//
//  JPNavigationController.m
//  WeChat_D
//
//  Created by tztddong on 16/9/5.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLNavigationController.h"

@interface LOLNavigationController ()

@end

@implementation LOLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置NavigationBar背景颜色
    [self.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_bar_bg_for_seven"]]];
    //@{}代表Dictionary
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:DefaultGodColor}];
    //设置item字体的颜色
    [self.navigationBar setTintColor:DefaultGodColor];
    //不设置这个无法修改状态栏字体颜色
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    

    NSLog(@"%zd",self.childViewControllers.count);
    //如果当前push进来是第一个控制器的话，（代表当前childViewCtrls里面是没有东西)
    if (self.childViewControllers.count) {
        //当前不是第一个子控制器，那么在push出去的时候隐藏底部的tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //这句代码的位置是一个关键
    [super pushViewController:viewController animated:animated];
    
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

@end
