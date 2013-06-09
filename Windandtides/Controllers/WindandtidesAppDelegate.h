//
//  WindandtidesAppDelegate.h
//  Windandtides
//
//  Created by Todd Huss on 5/15/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WindandtidesViewController;

@interface WindandtidesAppDelegate : NSObject <UIApplicationDelegate> {
}

@property(nonatomic, strong) IBOutlet UIWindow *window;
@property(nonatomic, strong) IBOutlet UITabBarController *tabBarController;

@end
