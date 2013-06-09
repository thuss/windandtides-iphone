//
//  WindandtidesAppDelegate.m
//  Windandtides
//
//  Created by Todd Huss on 5/15/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import "WindandtidesAppDelegate.h"
#import "WindandtidesViewController.h"
#import "Flurry.h"
#import <Crashlytics/Crashlytics.h>

@implementation WindandtidesAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;


- (void)configureUserAgent {
    NSDictionary *dictionnary = [NSDictionary dictionaryWithObjectsAndKeys:@"Windandtides Mobile App iPhone Mobile//Safari", @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
}

- (void)configureAnalytics {
    // Switch to non-test key for publishing
    [Flurry startSession:@"J17K15UXCE6897XDRNW3"];
    [Crashlytics startWithAPIKey:@"c8253a4d97f816e77bf561578ffa10063d8f4e06"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureUserAgent];
    [self configureAnalytics];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) applicationWillEnterForeground:(UIApplication *)application {
    [((WindandtidesViewController *)self.tabBarController.selectedViewController) reloadWebViews:nil];
}

@end
