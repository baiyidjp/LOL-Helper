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

@interface LOLNewsController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LOLNewsController
{
    ImageScrollView *_newsScrollView;
    UIButton *_headIconBtn;
    UIButton *_searchBtn;
    UITableView *_newsTableView;
    NSArray *_scrollImageArray;
    NSMutableArray *_newsListArray;
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
    [self.view addSubview:_newsTableView];
}

#pragma mark - request
- (void)requestNewsData
{
    [LOLRequest getWithUrl:LOL_URL_SCROLLIMAGE params:nil success:^(id responseObject) {
        NSArray *list = [responseObject objectForKey:@"list"];
        _scrollImageArray = [LOLNewsScrollCellModel mj_objectArrayWithKeyValuesArray:list];
        [self requestNewsList];
    } failure:^(NSError *error) {
        [self.view makeToast:@"请求出错"];
    }];
    
}

#pragma mark - news_list
- (void)requestNewsList{
    
    [LOLRequest getWithUrl:LOL_URL_NEWSLIST params:nil success:^(id responseObject) {
        NSLog(@"newslist -- %@",responseObject);
        NSArray *list = [responseObject objectForKey:@"list"];
        [_newsListArray removeAllObjects];
        if (list.count) {
            [_newsListArray addObjectsFromArray:[LOLNewsCellModel mj_objectArrayWithKeyValuesArray:list]];
            [_newsTableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.view makeToast:@"请求出错"];
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
    return _newsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LOLNewsScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOLNewsScrollCell"];
        cell.imageUrlArray = _scrollImageArray;
        return cell;
    }
    LOLNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOLNewsListCell"];
    cell.newsModel = [_newsListArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return KWIDTH*IMAGE_SCALE;
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

@end
