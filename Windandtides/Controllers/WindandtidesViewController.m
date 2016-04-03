//
//  WindandtidesViewController.m
//  Windandtides
//
//  Created by Todd Huss on 5/15/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import "WindandtidesViewController.h"

@implementation WindandtidesViewController

@synthesize activityIndicator = _activityIndicator;
@synthesize reloadButton = _reloadButton;
@synthesize mainWebView = _mainWebView;
@synthesize urlManager = _urlManager;
@synthesize swipeGestures = _swipeGestures;

#pragma mark - View lifecycle

- (void)viewDidUnload {
    [super viewDidUnload];
    self.activityIndicator = nil;
    self.reloadButton = nil;
    self.mainWebView = nil;
    self.urlManager = nil;
    self.swipeGestures = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator = [[MBProgressHUD alloc] initWithView:self.view];
    self.activityIndicator.labelText = @"Loading";
    [self.view addSubview:self.activityIndicator];
    self.urlManager = [[WindandtidesUrlManager alloc] init];
    [self loadWebView:self.tabBarItem.tag];
    self.swipeGestures = [[AnimatedSwipeGestures alloc] initWithController:self.tabBarController];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

#pragma mark - UIWebView and UIWebViewDelegate methods

- (void)loadWebView:(long)tabIndex {
    WindandtidesPages pageForTab[4] = {kForecast, kTidesAndCurrents, kAngelIslandWinds, kGoldenGateWinds};
    WindandtidesPages page = pageForTab[tabIndex];
    NSURL *url = [NSURL URLWithString:[self.urlManager urlFor:page]];    
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (IBAction)reloadWebViews:(UIButton *)button {
    [self.mainWebView reload]; // Start with our webview, then call reload on others
    for (WindandtidesViewController *controller in self.tabBarController.viewControllers) {
        if (controller != self) [controller.mainWebView reload];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.reloadButton setHidden:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.activityIndicator show:YES];    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.activityIndicator hide:YES];
    [self.reloadButton setHidden:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.activityIndicator hide:YES];
    // If the webview doesn't contain a valid URL, we have to reset baseURL for future reloads
    if ([self.mainWebView.request.URL.absoluteString length] == 0) {
        NSURL *url = [NSURL URLWithString:[error.userInfo objectForKey:@"NSErrorFailingURLStringKey"]];
        [self.mainWebView loadHTMLString:@"" baseURL:url];
    }
    // Show the alert if we're the currently selected controller
    if([[[self tabBarController] selectedViewController] isEqual:self]) {
        [[[UIAlertView alloc] initWithTitle:@"Network Error"
                                     message:@"Do you you want to retry?" delegate:self
                           cancelButtonTitle:@"Retry"
                           otherButtonTitles:@"Cancel", nil] show];
    }
}

# pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    int retryButtonIndex = 0;
    if (buttonIndex == retryButtonIndex) {
        [self reloadWebViews:nil];
    }
}


@end
