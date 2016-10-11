//
//  LOLNewsSpecialClassCell.m
//  LOL Helper
//
//  Created by tztddong on 16/10/11.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLNewsSpecialClassCell.h"
#import "LOLNewsSpecialClassView.h"
#import "LOLNewsClassModel.h"
#import "UIView+BlockGesture.h"

@implementation LOLNewsSpecialClassCell
{
    UIView *_backView;
    UIView *_lineView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"eeeff0"];
        [self configViews];
    }
    return self;
}

#pragma mark - 配置View
- (void)configViews
{
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor colorWithHexString:@"fcfbfd"];
    [self.contentView addSubview:_backView];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor colorWithHexString:@"d7d9df"];
    [self.contentView addSubview:_lineView];
}

- (void)setClassModels:(NSArray *)classModels
{
    _classModels = classModels;
    
    CGFloat backW = KWIDTH - 2*KMARGIN;
    CGFloat classW = (backW-KMARGIN*0.5)/2.0;
    CGFloat classH = 45;
    CGFloat classX,classY;
    
    for (NSInteger i = 0; i < classModels.count; i++) {
        
        LOLNewsClassModel *classModel = [classModels objectAtIndex:i];
        
        NSInteger lie = i % 2 ;
        NSInteger hang = i / 2;
        
        classX = lie*(classW+KMARGIN*0.5);
        classY = hang*classH;
        
        LOLNewsSpecialClassView *classView = [[LOLNewsSpecialClassView alloc]initWithFrame:CGRectMake(classX, classY,classW , classH)];
        classView.classModel = classModel;
        classView.userInteractionEnabled = YES;
        [_backView addSubview:classView];
        //增加点击事件
        [classView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            //点击调用代理 主页跳转
            if ([self.delegate respondsToSelector:@selector(didSelectSpecialClassBtnWithView:classModel:)]) {
                [self.delegate didSelectSpecialClassBtnWithView:self classModel:classModel];
            }
        }];
    }
    CGFloat row = (classModels.count-1)/2+1;
    _backView.frame = CGRectMake(KMARGIN, KMARGIN*0.5, KWIDTH-2*KMARGIN, row*classH);
    
    _lineView.frame = CGRectMake(_backView.left, CGRectGetMaxY(_backView.frame)+KMARGIN*0.5-1, _backView.width, 1);
}

@end
