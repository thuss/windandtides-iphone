//
//  WindandtidesViewController.m
//  Windandtides
//
//  Created by Todd Huss on 5/15/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import "WindandtidesViewController.h"
#import "WindandtidesUrlManager.h"
#import "AnimatedSwipeGestures.h"

@interface WindandtidesViewController()

@property (nonatomic, retain) WindandtidesUrlManager *urlManager;
@property (nonatomic, retain) AnimatedSwipeGestures *swipeGestures;

- (void)loadWebView:(int)tabIndex;

@end

@implementation WindandtidesViewController

@synthesize activityIndicator=_activityIndicator;
@synthesize mainWebView=_mainWebView;
@synthesize urlManager=_urlManager;
@synthesize swipeGestures=_swipeGestures;

- (void)dealloc {
    [super dealloc];
    [_activityIndicator release];
    [_mainWebView release];
    [_urlManager release];
    [_swipeGestures release];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];  
    self.urlManager = [[WindandtidesUrlManager alloc] init];
    [self loadWebView:self.tabBarItem.tag];   
    self.swipeGestures = [[AnimatedSwipeGestures alloc] initWithController:self.tabBarController];  
}

- (void)viewDidUnload {
    [super viewDidUnload];    
    self.activityIndicator = nil;
    self.mainWebView = nil;
    self.urlManager = nil;
    self.swipeGestures = nil;
}

#pragma mark - UIWebView and UIWebViewDelegate methods

- (void) loadWebView:(int)tabIndex {
    WindandtidesPages page = kForecast;
    switch (tabIndex) {
        case 1: page = kTidesAndCurrents; break;
        case 2: page = kAngelIslandWinds; break;
        case 3: page = kGoldenGateWinds; break;
    }
    NSURL *url = [NSURL URLWithString:[self.urlManager urlFor:page]];
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:url]];    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.activityIndicator stopAnimating];
    NSString* errorString = @"<html><center><br/><h1>Error retrieving Windandtides data<br/><br/>Check your network connection and press the reload button or try back later</h1></center></html>";    
    NSURL *url = [NSURL URLWithString:[error.userInfo objectForKey:@"NSErrorFailingURLStringKey"]];
    [self.mainWebView loadHTMLString:errorString baseURL:url];
}

@end
