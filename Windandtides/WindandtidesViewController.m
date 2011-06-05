//
//  WindandtidesViewController.m
//  Windandtides
//
//  Created by Todd Huss on 5/15/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import "WindandtidesViewController.h"

@interface WindandtidesViewController()

typedef enum { 
    kAnimateLeft, 
    kAnimateRight 
} AnimationDirection;

- (void)addSwipeGestureRecognizers;
- (void)loadWebView:(int)tabIndex;
- (void)animateSwipe:(int)tabIndex withDirection:(AnimationDirection)direction;

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
    [self loadWebView:self.tabBarItem.tag];    
    [self addSwipeGestureRecognizers];    
}

- (void)viewDidUnload {
    [super viewDidUnload];    
    self.activityIndicator = nil;
    self.mainWebView = nil;
}

# pragma mark - UISwipeGestureRecognizer methods

- (void)addSwipeGestureRecognizers {
    UISwipeGestureRecognizer *recognizerLeft;
    recognizerLeft = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)] autorelease];
    recognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;    
    [self.view addGestureRecognizer:recognizerLeft];
    
    UISwipeGestureRecognizer *recognizerRight;
    recognizerRight = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)] autorelease];
    recognizerRight.direction = UISwipeGestureRecognizerDirectionRight;    
    [self.view addGestureRecognizer:recognizerRight];
    
}

- (void)didSwipeRight:(UISwipeGestureRecognizer *)recognizer {    
    int tabIndex = ((self.tabBarItem.tag + 3) % 4);
    [self animateSwipe:tabIndex withDirection:kAnimateLeft];
}

- (void)didSwipeLeft:(UISwipeGestureRecognizer *)recognizer {    
    int tabIndex = ((self.tabBarItem.tag + 1) % 4);
    [self animateSwipe:tabIndex withDirection:kAnimateRight];
}

- (void)animateSwipe:(int)newTabIndex withDirection:(AnimationDirection)direction {
    // Get the views.
    UIView * fromView = self.tabBarController.selectedViewController.view;
    UIView * toView = [[self.tabBarController.viewControllers objectAtIndex:newTabIndex] view];    
    // Get the size of the view area.
    CGRect viewSize = fromView.frame;    
    // Add the to view to the tab bar view.
    [fromView.superview addSubview:toView];    
    // Position it off screen.
    toView.frame = CGRectMake((direction == kAnimateRight ? 320 : -320), viewSize.origin.y, 320, viewSize.size.height);
    // Run the animation
    [UIView animateWithDuration:0.3 
                     animations: ^{                         
                         // Animate the views on and off the screen. This will appear to slide.
                         fromView.frame =CGRectMake((direction == kAnimateRight ? -320 : 320), viewSize.origin.y, 320, viewSize.size.height);
                         toView.frame =CGRectMake(0, viewSize.origin.y, 320, viewSize.size.height);
                     }     
                     completion:^(BOOL finished) {
                         if (finished) {                             
                             // Remove the old view from the tabbar view.
                             [fromView removeFromSuperview];
                             self.tabBarController.selectedIndex = newTabIndex;                
                         }
                     }];
}

#pragma mark - UIWebView and UIWebViewDelegate methods

- (void) loadWebView:(int)tabIndex {
    NSArray *urls = [NSArray arrayWithObjects: 
                     @"http://windandtides.com/marine/forecast", 
                     @"http://windandtides.com/marine/tide", 
                     @"http://windandtides.com/marine/wind/Angel+Island", 
                     @"http://windandtides.com/marine/wind/Golden+Gate", 
                     nil];
    NSString *url = [urls objectAtIndex:tabIndex];
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];    
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
