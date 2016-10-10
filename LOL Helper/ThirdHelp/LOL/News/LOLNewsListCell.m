//
//  LOLNewsListCell.m
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLNewsListCell.h"
#import "LOLNewsCellModel.h"
#import "LOLReportView.h"

@implementation LOLNewsListCell
{
    UIView *_backView;
    UIImageView *_newsImage;
    UIImageView *_topImage;
    UIImageView *_videoImage;
    UILabel *_newsTitleLable;
    UILabel *_newsSummaryLabel;
    UILabel *_newsTimeLable;
    UILabel *_newsReadLabel;
    UILabel *_newsTypeLabel;
    LOLReportView *_newsReportView;
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
    
    _newsImage = [[UIImageView alloc]init];
    [_backView addSubview:_newsImage];
    
    _topImage = [[UIImageView alloc]init];
    [_newsImage addSubview:_topImage];
    
    _videoImage = [[UIImageView alloc]init];
    _videoImage.image = [UIImage imageNamed:@"news_cell_play"];
    [_newsImage addSubview:_videoImage];
    
    _newsTitleLable = [[UILabel alloc]init];
    _newsTitleLable.font = FONTSIZE(15);
    _newsTitleLable.textColor = [UIColor colorWithHexString:@"000000"];
    [_backView addSubview:_newsTitleLable];
    
    _newsSummaryLabel = [[UILabel alloc]init];
    _newsSummaryLabel.font = FONTSIZE(11);
    _newsSummaryLabel.textColor = [UIColor colorWithHexString:@"888888"];
    _newsSummaryLabel.numberOfLines = 2;
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
    
    _newsReportView = [[LOLReportView alloc]init];
    [_backView addSubview:_newsReportView];
}

- (void)setNewsModel:(LOLNewsCellModel *)newsModel
{
    _newsModel = newsModel;
    
    NSString *newsType = newsModel.newstype;
    
    [_newsImage sd_setImageWithURL:[NSURL URLWithString:newsModel.image_url_small] placeholderImage:[UIImage imageNamed:@""]];
    
    _topImage.image = [UIImage imageNamed:@"list_news_item_set_top_mark"];
    _topImage.hidden = ![newsModel.is_top boolValue];
    
    _newsTitleLable.text = newsModel.title;
    
    _newsSummaryLabel.text = newsModel.summary;
    _newsTimeLable.text = [LOLBaseMethod timeWithDate:newsModel.publication_date];
    
    BOOL isHiddenTime = [newsType isEqualToString:@"专题"];
    _newsReadLabel.hidden = _newsTimeLable.hidden = isHiddenTime;
    
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
    
    BOOL isHiddenReport = [newsType isEqualToString:@"战报"];
    if (isHiddenReport) {
        _newsReportView.newsModel = newsModel;
        _newsReportView.hidden = NO;
        _newsSummaryLabel.hidden = YES;
    }else{
        _newsReportView.hidden = YES;
        _newsSummaryLabel.hidden = NO;
    }
    
    NSString *typeColor;
    _newsTypeLabel.text = newsType;
    BOOL isHiddenType = newsType.length;
    _newsTypeLabel.hidden = !isHiddenType;
    //专题 视频 图集 战报 俱乐部
    if ([newsType isEqualToString:@"专题"]) {
        typeColor = @"5d9cec";
    }else if ([newsType isEqualToString:@"视频"]){
        typeColor = @"8bc151";
    }else if ([newsType isEqualToString:@"图集"]){
        typeColor = @"ffb258";
    }else if ([newsType isEqualToString:@"战报"]){
        typeColor = @"d0ac66";
    }else if ([newsType isEqualToString:@"俱乐部"]){
        typeColor = @"9793fe";
    }
    _newsTypeLabel.textColor = [UIColor colorWithHexString:typeColor];
    _newsTypeLabel.layer.borderColor = [UIColor colorWithHexString:typeColor].CGColor;
    
    _backView.frame = CGRectMake(KMARGIN, KMARGIN*0.5, KWIDTH-2*KMARGIN, 87.5);
    _newsImage.frame = CGRectMake(KMARGIN*0.5, KMARGIN, 90, 67.5);
    _topImage.frame = CGRectMake(0, 0, 30, 15);
    _videoImage.frame = CGRectMake(CGRectGetWidth(_newsImage.frame)/2.0-15, CGRectGetHeight(_newsImage.frame)/2.0-15, 30, 30);
    
    BOOL isHiddenPlayImage = [newsType isEqualToString:@"视频"];
    _videoImage.hidden = !isHiddenPlayImage;
    
    _newsTitleLable.frame = CGRectMake(CGRectGetMaxX(_newsImage.frame)+KMARGIN*0.5, CGRectGetMinY(_newsImage.frame), CGRectGetWidth(_backView.frame)-CGRectGetMaxX(_newsImage.frame)-KMARGIN, 15);

    CGFloat summaryH = [LOLBaseMethod LabelHeightofString:newsModel.summary withFont:FONTSIZE(11) withWidth:_newsTitleLable.width];
    _newsSummaryLabel.frame = CGRectMake(_newsTitleLable.left, CGRectGetMaxY(_newsTitleLable.frame)+KMARGIN*0.5, _newsTitleLable.width, summaryH);
    
    CGFloat timeW = [LOLBaseMethod LabelWidthOfString:_newsTimeLable.text withFont:FONTSIZE(11) withHeight:MAXFLOAT];
    _newsTimeLable.frame = CGRectMake(_newsTitleLable.left, CGRectGetMaxY(_newsImage.frame)-KMARGIN*0.6, timeW, 11);
    
    CGFloat readW = [LOLBaseMethod LabelWidthOfString:readText withFont:FONTSIZE(11) withHeight:MAXFLOAT];
    _newsReadLabel.frame = CGRectMake(CGRectGetMaxX(_newsTimeLable.frame)+KMARGIN*0.5, _newsTimeLable.top, readW, 11);
    
    CGFloat typeW = [LOLBaseMethod LabelWidthOfString:newsType withFont:FONTSIZE(11) withHeight:MAXFLOAT]+KMARGIN/2.0;
    _newsTypeLabel.frame = CGRectMake(CGRectGetWidth(_backView.frame)-typeW-KMARGIN*0.5, CGRectGetHeight(_backView.frame)-2*KMARGIN, typeW, 17);
    
    _newsReportView.frame = CGRectMake(_newsTitleLable.left, CGRectGetMidY(_newsImage.frame)-KMARGIN/2.0, _newsTitleLable.width, 11);
}

@end
