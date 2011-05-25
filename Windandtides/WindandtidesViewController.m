//
//  WindandtidesViewController.m
//  Windandtides
//
//  Created by Todd Huss on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WindandtidesViewController.h"

@interface WindandtidesViewController()
- (void)loadWebView:(UIWebView *)webView url:(NSString *)url;
@end

@implementation WindandtidesViewController

@synthesize forecastActivityIndicator=_forecastActivityIndicator;
@synthesize forecastWebView=_forecastWebView;
@synthesize tidesAndCurrentsWebView=_tidesAndCurrentsWebView;
@synthesize angelIslandWebView=_angelIslandWebView;
@synthesize goldenGateWebView=_goldenGateWebView;

- (void)dealloc
{
    [super dealloc];
    [_forecastActivityIndicator release];
    [_forecastWebView release];
    [_tidesAndCurrentsWebView release];
    [_angelIslandWebView release];
    [_goldenGateWebView release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib
- (void)viewDidLoad
{
    [super viewDidLoad];  
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self loadWebView:[self forecastWebView] url:@"http://localhost:3000/marine/forecast"];
//    [self.forecastActivityIndicator stopAnimating];
    [self loadWebView:[self tidesAndCurrentsWebView] url:@"http://localhost:3000/marine/tide"];
    [self loadWebView:[self angelIslandWebView] url:@"http://localhost:3000/marine/wind/Angel+Island"];
    [self loadWebView:[self goldenGateWebView] url:@"http://localhost:3000/marine/wind/Golden+Gate"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)loadWebView:(UIWebView *)webView url:(NSString *)url {
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIWebViewDelegate methods
- (void)webViewDidStartLoad:(UIWebView *)webView {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSString* errorString = @"<html><center><br/><br/><br/><br/><h1>Error loading Windandtides data<br/><br/>Try reloading again in a minute or so</h1></center></html>";
    [self.forecastWebView loadHTMLString:errorString baseURL:nil];
}

@end
