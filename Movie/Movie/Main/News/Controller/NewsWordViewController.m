//
//  NewsWordViewController.m
//  Movie
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "NewsWordViewController.h"

@interface NewsWordViewController ()
{
    UIActivityIndicatorView *aiview;
}

@end

@implementation NewsWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"文字新闻";
    
    
    
    // 添加 UIActivityIndicatorView 控件
    aiview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aiview];

    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
}


//UIWebView 代理协议
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"准备开始加载");
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
    [aiview startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完毕");
    [aiview stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"错误！");
    [aiview stopAnimating];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
