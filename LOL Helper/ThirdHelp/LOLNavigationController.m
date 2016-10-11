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
        // 导航栏的返回按钮
        UIImage *backImage = [UIImage imageNamed:@"nav_btn_back_tiny_normal"];
        backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 20)];
        [backBtn setImage:backImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.navigationItem.leftBarButtonItem = colseItem;
        
        
////    setp1:需要获取系统自带滑动手势的target对象
//        id target = self.navigationController.interactivePopGestureRecognizer.delegate;
////    setp2:创建全屏滑动手势~调用系统自带滑动手势的target的action方法
//        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
////    step3:设置手势代理~拦截手势触发
//        pan.delegate = self;
////    step4:别忘了~给导航控制器的view添加全屏滑动手势
//        [viewController.view addGestureRecognizer:pan];
////    step5:将系统自带的滑动手势禁用
//        viewController.navigationController.interactivePopGestureRecognizer.enabled = NO;

    }
    
    //这句代码的位置是一个关键
    [super pushViewController:viewController animated:animated];
    
}

- (void)backBtnPressed{
    [self popViewControllerAnimated:YES];
}

@end
