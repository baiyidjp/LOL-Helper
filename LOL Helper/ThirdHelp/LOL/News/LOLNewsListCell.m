//
//  LOLNewsListCell.m
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLNewsListCell.h"
#import "LOLNewsCellModel.h"

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
    [_backView addSubview:_newsTypeLabel];
    
}

- (void)setNewsModel:(LOLNewsCellModel *)newsModel
{
    _newsModel = newsModel;
    
    [_newsImage sd_setImageWithURL:[NSURL URLWithString:newsModel.image_url_small] placeholderImage:[UIImage imageNamed:@""]];
    _newsTitleLable.text = newsModel.title;
    _newsSummaryLabel.text = newsModel.summary;
    _newsTimeLable.text = [self timeFromTimestamp:newsModel.publication_date];
    
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
    
    _backView.frame = CGRectMake(KMARGIN, KMARGIN*0.5, KWIDTH-2*KMARGIN, 87.5);
    _newsImage.frame = CGRectMake(KMARGIN*0.5, KMARGIN, 90, 67.5);
    _topImage.frame = CGRectMake(0, 0, 30, 15);
    _newsTitleLable.frame = CGRectMake(CGRectGetMaxX(_newsImage.frame)+KMARGIN*0.5, CGRectGetMinY(_newsImage.frame), CGRectGetWidth(_backView.frame)-CGRectGetMaxX(_newsImage.frame)-KMARGIN, 15);

    CGFloat summaryH = [LOLBaseMethod LabelHeightofString:newsModel.summary withFont:FONTSIZE(11) withWidth:_newsTitleLable.width];
    _newsSummaryLabel.frame = CGRectMake(_newsTitleLable.left, CGRectGetMaxY(_newsTitleLable.frame)+KMARGIN*0.5, _newsTitleLable.width, summaryH);
    
    CGFloat timeW = [LOLBaseMethod LabelWidthOfString:_newsTimeLable.text withFont:FONTSIZE(11) withHeight:MAXFLOAT];
    _newsTimeLable.frame = CGRectMake(_newsTitleLable.left, CGRectGetMaxY(_newsImage.frame)-KMARGIN*0.5, timeW, 11);
    
    CGFloat readW = [LOLBaseMethod LabelWidthOfString:readText withFont:FONTSIZE(11) withHeight:MAXFLOAT];
    _newsReadLabel.frame = CGRectMake(CGRectGetMaxX(_newsTimeLable.frame)+KMARGIN*0.5, _newsTimeLable.top, readW, 11);
    _newsTypeLabel.frame = CGRectMake(CGRectGetWidth(_backView.frame)-3*KMARGIN-KMARGIN*0.5, CGRectGetHeight(_backView.frame)-2*KMARGIN, 3*KMARGIN, 17);
}

/**
  * 时间戳转成字符串
  *
  * @param timestamp 时间戳
  *
  * @return 格式化后的字符串
  */
- (NSString *)timeFromTimestamp:(NSString *)timestamp{

    NSDateFormatter *dateFormtter =[[NSDateFormatter alloc] init];
    dateFormtter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *d = [dateFormtter dateFromString:timestamp];
    NSTimeInterval late=[d timeIntervalSince1970]*1; //转记录的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1; //获取当前时间戳
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    // 发表在一小时之内
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString = @"1";
        }else{
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }

        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    // 在一小时以上24小以内
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    // 发表在24以上10天以内
    //86400 = 60(分)*60(秒)*24(小时) 3天内
    else if (cha/86400>1&&cha/86400*3<1) {
            timeString = [NSString stringWithFormat:@"%f", cha/86400];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    // 发表时间大于10天
    else {
            [dateFormtter setDateFormat:@"yyyy-MM-dd"];
            timeString = [dateFormtter stringFromDate:d];
    }

    return timeString;
}

@end