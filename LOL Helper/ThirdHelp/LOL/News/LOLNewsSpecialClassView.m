//
//  LOLNewsSpecialClassView.m
//  LOL Helper
//
//  Created by tztddong on 16/10/11.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLNewsSpecialClassView.h"
#import "LOLNewsClassModel.h"

@implementation LOLNewsSpecialClassView
{
    UILabel *_nameLabel;
    UILabel *_subTitle;
    UIImageView *_nameImg;
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
- (void)configViews
{
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = FONTSIZE(15);
    _nameLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    [self addSubview:_nameLabel];
    
    _subTitle = [[UILabel alloc]init];
    _subTitle.font = FONTSIZE(13);
    _subTitle.textColor = [UIColor colorWithHexString:@"ffffff"];
    [self addSubview:_subTitle];
    
    _nameImg = [[UIImageView alloc]init];
    [self addSubview:_nameImg];
}

- (void)setClassModel:(LOLNewsClassModel *)classModel
{
    _classModel = classModel;
    
    _nameLabel.text = classModel.name;
    _subTitle.text = classModel.subtitle;
    [_nameImg sd_setImageWithURL:[NSURL URLWithString:classModel.img] placeholderImage:[UIImage imageNamed:@""]];
    
    CGFloat nameW = [LOLBaseMethod LabelWidthOfString:classModel.name withFont:FONTSIZE(15) withHeight:MAXFLOAT];
    _nameLabel.frame = CGRectMake(15, KMARGIN*0.5, nameW, 15);
    
    CGFloat subW = [LOLBaseMethod LabelWidthOfString:classModel.subtitle withFont:FONTSIZE(13) withHeight:MAXFLOAT];
    _subTitle.frame = CGRectMake(_nameLabel.left, CGRectGetMaxY(_nameLabel.frame)+KMARGIN*0.7, subW, 13);
    
    CGFloat imgW = self.height*7.0/5;
    _nameImg.frame = CGRectMake(self.width - imgW, 0, imgW, self.height);
    
    self.backgroundColor = [UIColor colorWithHexString:classModel.bgcolor];
}

@end
