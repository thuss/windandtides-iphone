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
@synthesize mainWebView = _mainWebView;
@synthesize urlManager = _urlManager;
@synthesize swipeGestures = _swipeGestures;

- (void)dealloc {
    [_activityIndicator release];
    [_mainWebView release];
    [_urlManager release];
    [_swipeGestures release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.urlManager = [[[WindandtidesUrlManager alloc] init] autorelease];
    [self loadWebView:self.tabBarItem.tag];
    self.swipeGestures = [[[AnimatedSwipeGestures alloc] initWithController:self.tabBarController] autorelease];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.activityIndicator = nil;
    self.mainWebView = nil;
    self.urlManager = nil;
    self.swipeGestures = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

#pragma mark - UIWebView and UIWebViewDelegate methods

- (void)loadWebView:(int)tabIndex {
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
    // If the webview doesn't contain a valid URL, we have to reset baseURL for future reloads
    if ([self.mainWebView.request.URL.absoluteString length] == 0) {
        NSURL *url = [NSURL URLWithString:[error.userInfo objectForKey:@"NSErrorFailingURLStringKey"]];
        [self.mainWebView loadHTMLString:nil baseURL:url];
    }
    // Show the alert if we're the currently selected controller
    if([[[self tabBarController] selectedViewController] isEqual:self]) {
        [[[[UIAlertView alloc] initWithTitle:@"Network Error"
                                     message:@"Do you you want to retry?" delegate:self
                           cancelButtonTitle:@"Retry"
                           otherButtonTitles:@"Cancel", nil] autorelease] show];
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
