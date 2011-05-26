//
//  WindandtidesViewController.m
//  Windandtides
//
//  Created by Todd Huss on 5/15/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import "WindandtidesViewController.h"

@interface WindandtidesViewController()

@end

@implementation WindandtidesViewController

@synthesize activityIndicator=_activityIndicator;
@synthesize mainWebView=_mainWebView;

- (void)dealloc {
    [super dealloc];
    [_activityIndicator release];
    [_mainWebView release];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib
- (void)viewDidLoad {
    [super viewDidLoad];      
    NSArray *urls = [NSArray arrayWithObjects: 
                     @"http://localhost:3000/marine/forecast", 
                     @"http://localhost:3000/marine/tide", 
                     @"http://localhost:3000/marine/wind/Angel+Island", 
                     @"http://localhost:3000/marine/wind/Golden+Gate", 
                     nil];
    NSString *url = [urls objectAtIndex:self.tabBarItem.tag];
    NSLog(@"Current url is %@", url);
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - UIWebViewDelegate methods

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
    [self.mainWebView loadHTMLString:errorString baseURL:nil];
}

@end
