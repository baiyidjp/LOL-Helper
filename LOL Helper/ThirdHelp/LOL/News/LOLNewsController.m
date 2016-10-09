//
//  LOLNewsController.m
//  LOL Helper
//
//  Created by tztddong on 16/10/9.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLNewsController.h"
#import "ImageScrollView.h"

@interface LOLNewsController ()

@end

@implementation LOLNewsController
{
    ImageScrollView *_newsScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _newsScrollView = [ImageScrollView returnImageScrollViewWithFrame:CGRectMake(0, 0, KWIDTH, KWIDTH*9/16.0) imageUrl:nil isAutoScroll:NO];
}


@end
