//
//  WindandtidesViewController.h
//  Windandtides
//
//  Created by Todd Huss on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WindandtidesViewController : UIViewController { }

@property (nonatomic, retain) IBOutlet UIWebView *forecastWebView;
@property (nonatomic, retain) IBOutlet UIWebView *tidesAndCurrentsWebView;
@property (nonatomic, retain) IBOutlet UIWebView *angelIslandWebView;
@property (nonatomic, retain) IBOutlet UIWebView *goldenGateWebView;

@end
