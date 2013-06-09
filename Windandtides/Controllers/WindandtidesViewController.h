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
#import "MBProgressHUD.h"

@interface WindandtidesViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate> {
}

@property(nonatomic, strong) IBOutlet UIButton *reloadButton;
@property(nonatomic, strong) IBOutlet UIWebView *mainWebView;
@property(nonatomic, strong) MBProgressHUD *activityIndicator;
@property(nonatomic, strong) WindandtidesUrlManager *urlManager;
@property(nonatomic, strong) AnimatedSwipeGestures *swipeGestures;

- (IBAction)reloadWebViews:(UIButton *)button;

- (void)loadWebView:(int)tabIndex;

@end
