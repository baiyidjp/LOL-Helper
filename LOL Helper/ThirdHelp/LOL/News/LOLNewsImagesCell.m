//
//  LOLNewsImagesCell.m
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLNewsImagesCell.h"
#import "LOLNewsCellModel.h"

@implementation LOLNewsImagesCell
{
    UIView *_backView;
    UIImageView *_bigImageView;
    UIImageView *_smallImageView;
    UIImageView *_countImageView;
    UILabel *_countLabel;
    UILabel *_newsTitleLable;
    UILabel *_newsSummaryLabel;
    UILabel *_newsTimeLable;
    UILabel *_newsReadLabel;
    UILabel *_newsTypeLabel;
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
    
    _bigImageView = [[UIImageView alloc]init];
    [_bigImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    _bigImageView.contentMode =  UIViewContentModeScaleAspectFill;
    _bigImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _bigImageView.clipsToBounds  = YES;
    [_backView addSubview:_bigImageView];
    
    _smallImageView = [[UIImageView alloc]init];
    [_smallImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    _smallImageView.contentMode =  UIViewContentModeScaleAspectFill;
    _smallImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _smallImageView.clipsToBounds  = YES;
    [_backView addSubview:_smallImageView];
    
    _countImageView = [[UIImageView alloc]init];
    [_countImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    _countImageView.contentMode =  UIViewContentModeScaleAspectFill;
    _countImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _countImageView.clipsToBounds  = YES;
    [_backView addSubview:_countImageView];
    
    _countLabel = [[UILabel alloc]init];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.font = FONTSIZE(11);
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.backgroundColor = [UIColor blackColor];
    _countLabel.alpha = 0.8;
    [_countImageView addSubview:_countLabel];
    
    _newsTitleLable = [[UILabel alloc]init];
    _newsTitleLable.font = FONTSIZE(15);
    _newsTitleLable.textColor = [UIColor colorWithHexString:@"000000"];
    [_backView addSubview:_newsTitleLable];
    
    _newsSummaryLabel = [[UILabel alloc]init];
    _newsSummaryLabel.font = FONTSIZE(11);
    _newsSummaryLabel.textColor = [UIColor colorWithHexString:@"888888"];
    [_backView addSubview:_newsSummaryLabel];
    
    _newsTimeLable = [[UILabel alloc]init];
    _newsTimeLable.font = FONTSIZE(11);
    _newsTimeLable.textColor = [UIColor colorWithHexString:@"888888"];
    [_backView addSubview:_newsTimeLable];
    
    _newsReadLabel = [[UILabel alloc]init];
    _newsReadLabel.font = FONTSIZE(11);
    _newsReadLabel.textColor = [UIColor colorWithHexString:@"ddcea8"];
    [_backView addSubview:_newsReadLabel];
    
    _newsTypeLabel = [[UILabel alloc]init];
    _newsTypeLabel.font = FONTSIZE(11);
    _newsTypeLabel.layer.cornerRadius = 2;
    _newsTypeLabel.layer.borderWidth = 0.5;
    _newsTypeLabel.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:_newsTypeLabel];

}

- (void)setNewsModel:(LOLNewsCellModel *)newsModel
{
    _newsModel = newsModel;
    
    NSString *newsType = newsModel.newstype;
    
    _newsTitleLable.text = newsModel.title;
    _newsSummaryLabel.text = newsModel.summary;
    
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.big_image_url] placeholderImage:[UIImage imageNamed:@""]];
    [_smallImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.small_image_url] placeholderImage:[UIImage imageNamed:@""]];
    [_countImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.count_image_url] placeholderImage:[UIImage imageNamed:@""]];
    _countLabel.text = [NSString stringWithFormat:@"%@张",newsModel.count];
    
    _newsTimeLable.text = [LOLBaseMethod timeWithDate:newsModel.publication_date];
    
    NSString *readText;
    CGFloat read = [newsModel.pv floatValue]/10000;
    if (read < 1) {
        readText = [NSString stringWithFormat:@"%.0f阅",read*10000];
    }else if (read >= 1 && read < 10) {
        readText = [NSString stringWithFormat:@"%.1f万阅",read];
    }else{
        readText = [NSString stringWithFormat:@"%.0f万阅",read];
    }
    _newsReadLabel.text = readText;
    
    _newsTypeLabel.text = newsType;
    _newsTypeLabel.textColor = [UIColor colorWithHexString:@"ffb258"];
    _newsTypeLabel.layer.borderColor = [UIColor colorWithHexString:@"ffb258"].CGColor;
    
    _backView.frame = CGRectMake(KMARGIN, KMARGIN*0.5, KWIDTH-2*KMARGIN, 205);
    
    _newsTitleLable.frame = CGRectMake(KMARGIN*0.5, KMARGIN, CGRectGetWidth(_backView.frame)-KMARGIN, 15);
    
    _newsSummaryLabel.frame = CGRectMake(_newsTitleLable.left, CGRectGetMaxY(_newsTitleLable.frame)+KMARGIN*0.5, _newsTitleLable.width, 11);
    
    _smallImageView.frame = CGRectMake(CGRectGetWidth(_backView.frame)-KMARGIN*0.5-60, CGRectGetMaxY(_newsSummaryLabel.frame)+KMARGIN, 60, 60);
    
    _countImageView.frame = CGRectMake(_smallImageView.left, CGRectGetMaxY(_smallImageView.frame)+KMARGIN*0.5, 60, 60);
    
    _countLabel.frame = _countImageView.bounds;
    
    _bigImageView.frame = CGRectMake(KMARGIN*0.5, _smallImageView.top,CGRectGetMinX(_smallImageView.frame)-KMARGIN, 125);
    
    CGFloat timeW = [LOLBaseMethod LabelWidthOfString:_newsTimeLable.text withFont:FONTSIZE(11) withHeight:MAXFLOAT];
    _newsTimeLable.frame = CGRectMake(_newsTitleLable.left, CGRectGetMaxY(_bigImageView.frame)+KMARGIN, timeW, 11);
    
    CGFloat readW = [LOLBaseMethod LabelWidthOfString:readText withFont:FONTSIZE(11) withHeight:MAXFLOAT];
    _newsReadLabel.frame = CGRectMake(CGRectGetMaxX(_newsTimeLable.frame)+KMARGIN*0.5, _newsTimeLable.top, readW, 11);
    
    CGFloat typeW = [LOLBaseMethod LabelWidthOfString:newsType withFont:FONTSIZE(11) withHeight:MAXFLOAT]+KMARGIN/2.0;
    _newsTypeLabel.frame = CGRectMake(CGRectGetWidth(_backView.frame)-typeW-KMARGIN*0.5, CGRectGetHeight(_backView.frame)-2*KMARGIN, typeW, 17);

}

@end
