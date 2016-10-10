//
//  LOLReportView.m
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLReportView.h"
#import "LOLNewsCellModel.h"

@implementation LOLReportView
{
    UIImageView *_teamaLogo;
    UIImageView *_teambLogo;
    UILabel *_teamaName;
    UILabel *_teambName;
    UILabel *_marchResult;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self configViews];
    }
    return self;
}

#pragma mark - 配置Views
- (void)configViews{
    
    _teamaLogo = [[UIImageView alloc]init];
    [self addSubview:_teamaLogo];
    
    _teambLogo = [[UIImageView alloc]init];
    [self addSubview:_teambLogo];
    
    _teamaName = [[UILabel alloc]init];
    _teamaName.textColor = [UIColor colorWithHexString:@"acacad"];
    _teamaName.font = FONTSIZE(11);
    [self addSubview:_teamaName];
    
    _teambName = [[UILabel alloc]init];
    _teambName.textColor = [UIColor colorWithHexString:@"acacad"];
    _teambName.font = FONTSIZE(11);
    [self addSubview:_teambName];
    
    _marchResult = [[UILabel alloc]init];
    _marchResult.font = FONTSIZE(11);
    [self addSubview:_marchResult];
}

- (void)setNewsModel:(LOLNewsCellModel *)newsModel
{
    _newsModel = newsModel;
    
    [_teamaLogo sd_setImageWithURL:[NSURL URLWithString:newsModel.teama_logo] placeholderImage:[UIImage imageNamed:@""]];
    [_teambLogo sd_setImageWithURL:[NSURL URLWithString:newsModel.teamb_logo] placeholderImage:[UIImage imageNamed:@""]];
    
    _teamaName.text = newsModel.teama_name;
    _teambName.text = newsModel.teamb_name;
    
    _marchResult.text = newsModel.march_result;
    
    _teamaLogo.frame = CGRectMake(0, 0, 20, self.height);
    
    CGFloat nameaW = [LOLBaseMethod LabelWidthOfString:newsModel.teama_name withFont:FONTSIZE(11) withHeight:MAXFLOAT];
    _teamaName.frame = CGRectMake(CGRectGetMaxX(_teamaLogo.frame)+2, 0, nameaW, 11);
    
    CGFloat resultW = [LOLBaseMethod LabelWidthOfString:newsModel.march_result withFont:FONTSIZE(11) withHeight:MAXFLOAT];
    _marchResult.frame = CGRectMake(CGRectGetMaxX(_teamaName.frame)+KMARGIN/2.0, 0, resultW, 11);
    
    _teambLogo.frame = CGRectMake(CGRectGetMaxX(_marchResult.frame)+KMARGIN/2.0, 0, 20, self.height);
    
    CGFloat namebW = [LOLBaseMethod LabelWidthOfString:newsModel.teamb_name withFont:FONTSIZE(11) withHeight:MAXFLOAT];
    _teambName.frame = CGRectMake(CGRectGetMaxX(_teambLogo.frame)+2, 0, namebW, 11);
}

@end
