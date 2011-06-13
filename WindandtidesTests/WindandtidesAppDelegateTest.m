//
//  WindandtidesTests.m
//  WindandtidesTests
//
//  Created by Todd Huss on 5/15/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>
#import "WindandtidesAppDelegate.h"
#import "WindandtidesViewController.h"
#import "Macros.h"

@interface WindandtidesAppDelegateTest : SenTestCase {}
@end

@implementation WindandtidesAppDelegateTest

WindandtidesAppDelegate *appDelegate;

- (void)setUp {
    [super setUp];
    appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)tearDown {
    // Tear-down code here.    
    [super tearDown];
}

- (void)testWindandtidesAppDelegate { 
    assertThat([appDelegate class], equalTo([WindandtidesAppDelegate class]));    
}

- (void)testOutletsAreConnectedToNib {
    assertThat(appDelegate.window, notNilValue());
    assertThat(appDelegate.tabBarController, notNilValue());
}

- (void)testThatForecastIsTheFirstTab {
    assertThat([appDelegate.tabBarController.selectedViewController title], equalTo(@"Forecast"));    
}

- (void)testEachTabWiredToViewController {
    UITabBarController *controller = appDelegate.tabBarController;
    assertThat(controller.selectedViewController, notNilValue());
    assertThat(controller.viewControllers, hasCountOf(4));
    for (id c in controller.viewControllers) assertThat(c, instanceOf([WindandtidesViewController class]));
}

@end
