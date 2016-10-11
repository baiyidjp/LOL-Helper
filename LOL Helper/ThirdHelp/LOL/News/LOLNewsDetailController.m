//
//  BaseListDetailController.m
//  MeiKeLaMei
//
//  Created by tztddong on 16/6/16.
//  Copyright © 2016年 gyk. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "LOLNewsDetailController.h"
#import "CustomTopView.h"

#define IOS8x ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#define WebViewNav_TintColor ([UIColor orangeColor])

@interface LOLNewsDetailController ()<UIWebViewDelegate,UIActionSheetDelegate,WKNavigationDelegate>
@property (assign, nonatomic) NSUInteger loadCount;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) WKWebView *wkWebView;
@end

@implementation LOLNewsDetailController
{
    NSInteger current_type;
    NSString *topTitle;
    NSArray *titleArray;
    UIView *backLoadView;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [LOLRequest cancelAllOperations];
//    [self.navigationController.navigationBar setHidden:NO];
}

- (instancetype)initWithType:(NSInteger)VC_type{
    
    self = [super init];
    if (self) {
        current_type = VC_type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    backLoadView = [[UIView alloc]init];
    [self.view addSubview:backLoadView];
    [backLoadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(KNAVHEIGHT);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];
    [backLoadView layoutIfNeeded];
    
    self.title = @"资讯详情";
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
    [self configViews];
}

- (void)configViews{
    
    // 进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, KNAVHEIGHT, self.view.frame.size.width, 0)];
    progressView.tintColor = DefaultGodColor;
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    // 网页
    if (IOS8x) {
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, KNAVHEIGHT, KWIDTH, KHEIGHT-KNAVHEIGHT)];
        wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        wkWebView.backgroundColor = [UIColor whiteColor];
        wkWebView.navigationDelegate = self;
        [self.view insertSubview:wkWebView belowSubview:progressView];
        
        [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [wkWebView loadRequest:request];
        self.wkWebView = wkWebView;
        
    }else {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, KNAVHEIGHT, KWIDTH, KHEIGHT-KNAVHEIGHT)];
        webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        webView.scalesPageToFit = YES;
        webView.backgroundColor = [UIColor whiteColor];
        webView.delegate = self;
        [self.view insertSubview:webView belowSubview:progressView];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [webView loadRequest:request];
        self.webView = webView;
        
    }
}

#pragma mark - wkWebView代理

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

// 记得取消监听
- (void)dealloc {
    if (IOS8x) {
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}

#pragma mark - webView代理

// 计算webView进度条
- (void)setLoadCount:(NSUInteger)loadCount {
    _loadCount = loadCount;
    if (loadCount == 0) {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }else {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95) {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.loadCount ++;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.loadCount --;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.loadCount --;
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // 类似UIWebView的 -webViewDidStartLoad:
    
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // 类似 UIWebView 的 －webViewDidFinishLoad:
    
}
@end
