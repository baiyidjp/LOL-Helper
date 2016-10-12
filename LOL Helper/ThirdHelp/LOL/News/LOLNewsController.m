//
//  LOLNewsController.m
//  LOL Helper
//
//  Created by tztddong on 16/10/9.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLNewsController.h"
#import "ImageScrollView.h"
#import "LOLNewsScrollCell.h"
#import "LOLNewsScrollCellModel.h"
#import "LOLNewsListCell.h"
#import "LOLNewsCellModel.h"
#import "LOLNewsImagesCell.h"
#import "LOLNewsClassModel.h"
#import "LOLNewsSpecialClassCell.h"
#import "LOLNewsNormalClassView.h"
#import "LOLNewsDetailController.h"

@interface LOLNewsController ()<UITableViewDelegate,UITableViewDataSource,LOLNewsSpecialClassCellDeleagte,LOLNewsNormalClassViewDeleagte>

@end

@implementation LOLNewsController
{
    ImageScrollView *_newsScrollView;
    UIButton *_headIconBtn;
    UIButton *_searchBtn;
    UITableView *_newsTableView;
    NSArray *_scrollImageArray;
    NSMutableArray *_newsListArray;
    NSString *_classID;
    NSMutableArray *_newsNormalClass;
    NSMutableArray *_newsSpecialClass;
    LOLNewsNormalClassView *_newsNormalClassView;
    LOLNewsNormalClassView *_newsNormalClassViewHead;
    BOOL _isHiddenSpecialClassView;
    NSString *_defaultClassID;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.0];
    self.navigationItem.title = @"";
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _newsListArray = [NSMutableArray array];
    _newsNormalClass = [NSMutableArray array];
    _newsSpecialClass = [NSMutableArray array];
    
    [self configViews];
    [self requestNewsData];
    [self configRefresh];
}

#pragma mark - 创建view
- (void)configViews
{
    _headIconBtn = [[UIButton alloc]init];
    _headIconBtn.layer.cornerRadius = 20;
    _headIconBtn.layer.borderWidth = 2;
    _headIconBtn.layer.borderColor = DefaultGodColor.CGColor;
    _headIconBtn.frame = CGRectMake(2*KMARGIN, 2*KMARGIN+2, 40, 40);
    [_headIconBtn setTitle:@"头像" forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_headIconBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _searchBtn = [[UIButton alloc]init];
    [_searchBtn setImage:[UIImage imageNamed:@"nav_search"] forState:UIControlStateNormal];
    [_searchBtn setImage:[UIImage imageNamed:@"nav_search_hl"] forState:UIControlStateHighlighted];
    [_searchBtn setBackgroundColor:[UIColor blackColor]];
    _searchBtn.layer.cornerRadius = 20;
    _searchBtn.frame = CGRectMake(2*KMARGIN, 2*KMARGIN+2, 40, 40);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_searchBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    _newsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-KTABBARHEIGHT) style:UITableViewStylePlain];
    _newsTableView.delegate = self;
    _newsTableView.dataSource = self;
    _newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _newsTableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [_newsTableView registerClass:[LOLNewsScrollCell class] forCellReuseIdentifier:@"LOLNewsScrollCell"];
    [_newsTableView registerClass:[LOLNewsListCell class] forCellReuseIdentifier:@"LOLNewsListCell"];
    [_newsTableView registerClass:[LOLNewsImagesCell class] forCellReuseIdentifier:@"LOLNewsImagesCell"];
    [_newsTableView registerClass:[LOLNewsSpecialClassCell class] forCellReuseIdentifier:@"LOLNewsSpecialClassCell"];
    [self.view addSubview:_newsTableView];
    
    _newsNormalClassView = [[LOLNewsNormalClassView alloc]initWithFrame:CGRectMake(0,KNAVHEIGHT, KWIDTH, 44)];
    _newsNormalClassView.hidden = YES;
    [self.view addSubview:_newsNormalClassView];
    
    _newsNormalClassViewHead = [[LOLNewsNormalClassView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 44)];
}

#pragma mark - refresh
- (void)configRefresh{
    
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger i = 1; i < 9; i++) {
        NSString *imageName = [NSString stringWithFormat:@"personal_refresh_loading2%zd",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [images addObject:image];
    }
    // Set the callback（一Once you enter the refresh status，then call the action of target，that is call [self loadNewData]）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNewsData)];
    // Set the ordinary state of animated images
    [header setImages:[images copy] forState:MJRefreshStateIdle];
    // Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
    [header setImages:[images copy] forState:MJRefreshStatePulling];
    // Set the refreshing state of animated images
    [header setImages:[images copy] forState:MJRefreshStateRefreshing];
    // Set header
    header.lastUpdatedTimeLabel.hidden = YES;
    _newsTableView.mj_header = header;
}

#pragma mark - request
- (void)requestNewsData
{
    [LOLRequest getWithUrl:LOL_URL_SCROLLIMAGE params:nil success:^(id responseObject) {
        NSArray *list = [responseObject objectForKey:@"list"];
        _scrollImageArray = [LOLNewsScrollCellModel mj_objectArrayWithKeyValuesArray:list];
        [_newsTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        [self requestClass];
    } failure:^(NSError *error) {
        [self.view makeToast:@"requestNewsData请求出错"];
        [_newsTableView.mj_header endRefreshing];
    }];
    
}

#pragma mark - class_list
- (void)requestClass{
    
    [LOLRequest getWithUrl:LOL_CLASS params:nil success:^(id responseObject) {
        NSArray *classModels = [LOLNewsClassModel mj_objectArrayWithKeyValuesArray:responseObject];
        [_newsNormalClass removeAllObjects];
        [_newsSpecialClass removeAllObjects];
        for (LOLNewsClassModel *classModel in classModels) {
            BOOL is_entry = [classModel.is_entry boolValue];
            if (is_entry) {
                [_newsSpecialClass addObject:classModel];
            }else{
                [_newsNormalClass addObject:classModel];
            }
        }
        _defaultClassID = [[_newsNormalClass firstObject] id];
        [_newsTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        if (_classID.length && ![_classID isEqualToString:_defaultClassID]) {
            _isHiddenSpecialClassView = YES;
        }else{
            _isHiddenSpecialClassView = !_newsSpecialClass.count;
        }
        [self requestNewsList];
    } failure:^(NSError *error) {
        [self.view makeToast:@"requestClass请求出错"];
        [_newsTableView.mj_header endRefreshing];
    }];
}

#pragma mark - news_list
- (void)requestNewsList{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_classID.length ? _classID : _defaultClassID forKey:@"id"];
    [params setObject:@0 forKey:@"page"];
    [params setObject:@"ios" forKey:@"plat"];
    [params setObject:@33 forKey:@"version"];
    
    [LOLRequest getWithUrl:LOL_URL_NEWSLIST params:params success:^(id responseObject) {
        NSArray *list = [responseObject objectForKey:@"list"];
        [_newsListArray removeAllObjects];
        if (list.count) {
            [_newsListArray addObjectsFromArray:[LOLNewsCellModel mj_objectArrayWithKeyValuesArray:list]];
            [_newsTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];

        }
        [_newsTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.view makeToast:@"requestNewsList请求出错"];
        [_newsTableView.mj_header endRefreshing];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    if (section == 1) {
        return 0;
    }
    
    return _isHiddenSpecialClassView ? _newsListArray.count : _newsListArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LOLNewsScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOLNewsScrollCell"];
        cell.imageUrlArray = _scrollImageArray;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    LOLNewsCellModel *newsModel;
    if (!_isHiddenSpecialClassView) {//需要特殊的class
        if (indexPath.row == 0) {
            LOLNewsSpecialClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOLNewsSpecialClassCell"];
            cell.classModels = _newsSpecialClass;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }
        newsModel = [_newsListArray objectAtIndex:indexPath.row-1];
    }else{
        newsModel = [_newsListArray objectAtIndex:indexPath.row];
    }
    if ([newsModel.newstype isEqualToString:@"图集"]) {
        LOLNewsImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOLNewsImagesCell"];
        cell.newsModel = newsModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    LOLNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOLNewsListCell"];
    cell.newsModel = newsModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return KWIDTH*IMAGE_SCALE;
    }
    
    LOLNewsCellModel *newsModel;
    if (!_isHiddenSpecialClassView) {//需要特殊的class
        if (indexPath.row == 0) {
            CGFloat row = (_newsSpecialClass.count-1)/2+1;
            return row*45+KMARGIN;
        }
        newsModel = [_newsListArray objectAtIndex:indexPath.row-1];
    }else{
        newsModel = [_newsListArray objectAtIndex:indexPath.row];
    }
    if ([newsModel.newstype isEqualToString:@"图集"]) {
        return 210;
    }

    return 92.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 44;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        _newsNormalClassView.classID = _classID.length ? _classID : _defaultClassID;
        _newsNormalClassView.classModels = _newsNormalClass;
        _newsNormalClassView.delegate = self;
        _newsNormalClassViewHead.classID = _newsNormalClassView.classID;
        _newsNormalClassViewHead.classModels = _newsNormalClass;
        _newsNormalClassViewHead.delegate = self;
        return _newsNormalClassViewHead;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        //跳转
        LOLNewsCellModel *newsModel;
        if (!_isHiddenSpecialClassView) {//需要特殊的class
            newsModel = [_newsListArray objectAtIndex:indexPath.row-1];
        }else{
            newsModel = [_newsListArray objectAtIndex:indexPath.row];
        }

        LOLNewsDetailController *detailVC = [[LOLNewsDetailController alloc]init];
        detailVC.url = newsModel.article_url;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
#pragma mark 隐藏导航栏
    if (offsetY > KWIDTH*IMAGE_SCALE - KNAVHEIGHT) {
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
        self.navigationItem.title = @"董江鹏";
        _newsTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _newsNormalClassView.hidden = NO;
    }else{
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.0];
        self.navigationItem.title = @"";
        _newsTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _newsNormalClassView.hidden = YES;
    }
}

#pragma mark 代理
- (void)didSelectSpecialClassBtnWithView:(LOLNewsSpecialClassCell *)specialClassView classModel:(LOLNewsClassModel *)classModel
{
    NSLog(@"select-- %@",classModel.name);
}

- (void)didSelectNoamalClassBtnWithView:(LOLNewsNormalClassView *)noamalClassView classModel:(LOLNewsClassModel *)classModel
{
    if ([classModel.name isEqualToString:@"收藏"]) {
        return;
    }
    _classID = classModel.id;
    if ([_defaultClassID isEqualToString:_classID]) {
        _isHiddenSpecialClassView = NO;
    }else{
        _isHiddenSpecialClassView = YES;
    }
    [self requestNewsList];
}

@end
