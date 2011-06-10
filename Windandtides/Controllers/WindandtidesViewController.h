//
//  WindandtidesViewController.h
//  Windandtides
//
//  Created by Todd Huss on 5/15/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WindandtidesViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate> {
}

@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic, retain) IBOutlet UIWebView *mainWebView;

@end
