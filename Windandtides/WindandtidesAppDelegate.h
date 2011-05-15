//
//  WindandtidesAppDelegate.h
//  Windandtides
//
//  Created by Todd Huss on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WindandtidesViewController;

@interface WindandtidesAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet WindandtidesViewController *viewController;

@end
