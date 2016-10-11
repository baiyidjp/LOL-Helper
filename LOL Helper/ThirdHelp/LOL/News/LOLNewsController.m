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
    
    _newsNormalClassView = [[LOLNewsNormalClassView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 44)];
}

#pragma mark - request
- (void)requestNewsData
{
    [LOLRequest getWithUrl:LOL_URL_SCROLLIMAGE params:nil success:^(id responseObject) {
        NSArray *list = [responseObject objectForKey:@"list"];
        _scrollImageArray = [LOLNewsScrollCellModel mj_objectArrayWithKeyValuesArray:list];
        [_newsTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        [self requestClass];
    } failure:^(NSError *error) {
        [self.view makeToast:@"requestNewsData请求出错"];
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
        _classID = [[_newsNormalClass firstObject] id];
        _defaultClassID = _classID;
        _newsNormalClassView.classModels = _newsNormalClass;
        [_newsTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        _isHiddenSpecialClassView = !_newsSpecialClass.count;
        [self requestNewsList];
    } failure:^(NSError *error) {
        [self.view makeToast:@"requestClass请求出错"];
    }];
}

#pragma mark - news_list
- (void)requestNewsList{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_classID forKey:@"id"];
    [params setObject:@0 forKey:@"page"];
    [params setObject:@"ios" forKey:@"plat"];
    [params setObject:@33 forKey:@"version"];
    
    [LOLRequest getWithUrl:LOL_URL_NEWSLIST params:params success:^(id responseObject) {
        NSArray *list = [responseObject objectForKey:@"list"];
        [_newsListArray removeAllObjects];
        if (list.count) {
            [_newsListArray addObjectsFromArray:[LOLNewsCellModel mj_objectArrayWithKeyValuesArray:list]];
            [_newsTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        }
    } failure:^(NSError *error) {
        [self.view makeToast:@"requestNewsList请求出错"];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
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
        _newsNormalClassView.delegate = self;
        return _newsNormalClassView;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
#pragma mark 隐藏导航栏
    if (offsetY > KWIDTH*IMAGE_SCALE - KNAVHEIGHT) {
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
        self.navigationItem.title = @"董江鹏";
        _newsTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }else{
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.0];
        self.navigationItem.title = @"";
        _newsTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
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
