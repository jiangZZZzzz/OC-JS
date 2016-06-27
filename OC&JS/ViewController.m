//
//  ViewController.m
//  OC&JS
//
//  Created by jiangZzz on 16/6/27.
//  Copyright © 2016年 jiangZzz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    //[self.webView loadRequest:request];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"html"];
    
    NSString *urlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView loadHTMLString:urlStr baseURL:[NSURL URLWithString:path]];
    
    [self.view addSubview:self.webView];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 第二步  js all app method
    
    
    NSURL *url = [request URL];
    NSLog(@"url : %@, scheme : %@, query : %@",url,[url scheme],[url query]);

    NSString *urlStr = [url absoluteString];
    NSLog(@"absoluteString --> %@",urlStr);
    
    if ([[url scheme] isEqualToString:@"jscalloc"]) {
        NSArray *arr = [urlStr componentsSeparatedByString:@"://"];
        NSString *methodName = [arr lastObject];
        
        SEL sel = NSSelectorFromString(methodName);
        
        [self performSelector:sel];
        
    }
    
    return YES;
}

- (void)test {
    NSLog(@"i love jiang beibei");
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    // 第一步 app call js method
    //[self.webView stringByEvaluatingJavaScriptFromString:@"alert()"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
