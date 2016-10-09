//
//  CustomTopView.m
//  MeiKeLaMei
//
//  Created by tztddong on 16/6/13.
//  Copyright © 2016年 gyk. All rights reserved.
//

#import "CustomTopView.h"

@implementation CustomTopView
{
    UILabel *titleLabel;
}
+ (CustomTopView *)returnCustomTopViewWithTitle:(NSString *)title controller:(UIViewController *)ctrl isHiddenBack:(BOOL)isHiddenBack{

    return [[[self class]alloc]initWithTitle:title controller:ctrl isHiddenBack:isHiddenBack];
}

- (instancetype)initWithTitle:(NSString *)title controller:(UIViewController *)ctrl isHiddenBack:(BOOL)isHiddenBack{

    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 20, KWIDTH, 44);
        self.title = title;
        self.ctrl = ctrl;
        self.isHiddenBack = isHiddenBack;
        self.backgroundColor = [UIColor whiteColor];
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"GYKfanhui"] forState:UIControlStateNormal];
    backBtn.hidden = self.isHiddenBack;
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KMARGIN+KMARGIN/2);
        make.top.offset(self.mj_h/2-10);
        make.width.equalTo(@11);
        make.height.equalTo(@20);
    }];
    
    UIButton *backBtnTop = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtnTop setBackgroundColor:[UIColor clearColor]];
    [backBtnTop addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    backBtnTop.hidden = self.isHiddenBack;
    [self addSubview:backBtnTop];
    [backBtnTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KMARGIN);
        make.top.offset(self.mj_h/2-10);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor colorFromHexString:@"000000"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(backBtn.mas_centerY);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorFromHexString:@"e5e5e5"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.equalTo(@1);
    }];
}

- (void)backBtn{

    [self.ctrl.navigationController popViewControllerAnimated:YES];
}

- (void)setUpdateTitle:(NSString *)updateTitle{
    
    _updateTitle = updateTitle;
    titleLabel.text = updateTitle;
}

@end
