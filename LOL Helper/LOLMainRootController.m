//
//  MainRootController.m
//  LOL Helper
//
//  Created by tztddong on 16/10/9.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLMainRootController.h"
#import "LOLNewsController.h"
#import "LOLMeViewController.h"
#import "LOLFriendController.h"
#import "LOLFoundController.h"
#import "LOLNavigationController.h"

@interface LOLMainRootController ()

@end

@implementation LOLMainRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *titleArray = @[@"资讯",@"好友",@"发现",@"我"];
    NSArray *imageArray = @[@"tab_icon_news_normal",@"tab_icon_friend_normal",@"tab_icon_quiz_normal",@"tab_icon_more_normal"];
    NSArray *selectImageArray = @[@"tab_icon_news_press",@"tab_icon_friend_press",@"tab_icon_quiz_press",@"tab_icon_more_press"];
    LOLNewsController *newsController = [[LOLNewsController alloc]init];
    LOLFriendController *friendController = [[LOLFriendController alloc]init];
    LOLFoundController *foundController = [[LOLFoundController alloc]init];
    LOLMeViewController *meViewController = [[LOLMeViewController alloc]init];
    NSArray *ctrlArray = @[newsController,friendController,foundController,meViewController];
    
    for (NSInteger i = 0; i < titleArray.count; i++) {
        [self setControllersWithController:ctrlArray[i] Title:titleArray[i] ImageName:imageArray[i] SelectImageName:selectImageArray[i]];
    }

}

- (void)setControllersWithController:(UIViewController *)controller Title:(NSString *)title ImageName:(NSString *)imageName SelectImageName:(NSString *)selectImageName
{
    
    controller.title = title;
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : DefaultGodColor} forState:UIControlStateSelected];
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"888888"]} forState:UIControlStateNormal];

    LOLNavigationController *navCtrl = [[LOLNavigationController alloc]initWithRootViewController:controller];
    [self addChildViewController:navCtrl];

}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }

    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
}

@end
