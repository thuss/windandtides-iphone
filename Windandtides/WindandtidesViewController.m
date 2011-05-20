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

@synthesize forecastWebView=_forecastWebView;
@synthesize tidesAndCurrentsWebView=_tidesAndCurrentsWebView;
@synthesize angelIslandWebView=_angelIslandWebView;
@synthesize goldenGateWebView=_goldenGateWebView;

- (void)dealloc
{
    [super dealloc];
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
    [self loadWebView:[self forecastWebView] url:@"http://localhost:3000/marine/forecast"];
    [self loadWebView:[self tidesAndCurrentsWebView] url:@"http://localhost:3000/marine/tide"];
    [self loadWebView:[self angelIslandWebView] url:@"http://localhost:3000/marine/wind/Angel+Island"];
    [self loadWebView:[self goldenGateWebView] url:@"http://localhost:3000/marine/wind/Golden+Gate"];
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

@end
