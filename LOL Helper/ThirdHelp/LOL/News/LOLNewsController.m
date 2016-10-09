//
//  LOLNewsController.m
//  LOL Helper
//
//  Created by tztddong on 16/10/9.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLNewsController.h"
#import "ImageScrollView.h"

@interface LOLNewsController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LOLNewsController
{
    ImageScrollView *_newsScrollView;
    UIButton *_headIconBtn;
    UIButton *_searchBtn;
    UITableView *_newsTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.0];
    self.navigationItem.title = @"";
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    _newsScrollView = [ImageScrollView returnImageScrollViewWithFrame:CGRectMake(0, 0, KWIDTH, KWIDTH*9/16.0) imageUrl:nil isAutoScroll:NO];
    
    [self configViews];
}

#pragma mark - 创建view
- (void)configViews{
    
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
    [self.view addSubview:_newsTableView];
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd组 %zd行",indexPath.section,indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y; //+ tableView.contentInset.top;//注意
    NSLog(@"%f",offsetY);
    CGFloat panTranslationY = [scrollView.panGestureRecognizer translationInView:_newsTableView].y;//在tableVIEW的移动的坐标
#pragma mark 隐藏导航栏
    if (offsetY > 64) {
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
        self.navigationItem.title = @"董江鹏";
    }else{
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.0];
        self.navigationItem.title = @"";
    }
}

@end
