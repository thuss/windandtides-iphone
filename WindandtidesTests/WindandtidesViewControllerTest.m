//
//  WindandtidesViewControllerTest.m
//  Windandtides
//
//  Created by Todd Huss on 6/10/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>
#import "WindandtidesViewController.h"
#import "Macros.h"

@interface WindandtidesViewControllerTest : SenTestCase {}
@end

@implementation WindandtidesViewControllerTest

WindandtidesViewController *controller;

- (void)setUp {
    [super setUp];
    controller = [[WindandtidesViewController alloc] initWithNibName:@"MainWebView" bundle:nil];
}

- (void)tearDown {
    [controller release];
    [super tearDown];
}

- (void)testIBOutletsAreConnectedToNib {
    [controller loadView];
    assertThat(controller.mainWebView, notNilValue());
    assertThat(controller.activityIndicator, notNilValue());
}

- (void)testLoadView {     
    [controller loadView];
}

@end
