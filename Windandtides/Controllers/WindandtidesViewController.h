//
//  WindandtidesViewController.h
//  Windandtides
//
//  Created by Todd Huss on 5/15/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WindandtidesUrlManager.h"
#import "AnimatedSwipeGestures.h"

@interface WindandtidesViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate> {
}

@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic, retain) IBOutlet UIWebView *mainWebView;
@property(nonatomic, retain) WindandtidesUrlManager *urlManager;
@property(nonatomic, retain) AnimatedSwipeGestures *swipeGestures;

- (IBAction)reloadWebViews:(UIButton *)button;

- (void)loadWebView:(int)tabIndex;

@end
