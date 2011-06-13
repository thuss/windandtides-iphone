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
#import <OCMock/OCMock.h>
#import "WindandtidesViewController.h"
#import "Macros.h"

@interface WindandtidesViewControllerTest : SenTestCase {}
@end

@implementation WindandtidesViewControllerTest

WindandtidesViewController *controller;

- (void)setUp {
    [super setUp];
    controller = [[WindandtidesViewController alloc] init];
}

- (void)tearDown {
    [controller release];
    [super tearDown];
}

- (void)testOutletsAreConnectedToNib {
    [controller loadView];
    assertThat(controller.mainWebView, notNilValue());
    assertThat(controller.activityIndicator, notNilValue());
}

- (void)testViewDidLoad {       
    id mockWebView = [OCMockObject mockForClass:[UIWebView class]];
    [[mockWebView expect] loadRequest:[OCMArg checkWithBlock:^(id request) { 
        NSString *url = ((NSURLRequest *)request).URL.absoluteString;
        assertThat(url, equalTo(@"http://windandtides.com/marine/forecast"));
        return YES; 
    }]];
    controller.mainWebView = mockWebView;
    [controller viewDidLoad];
    [mockWebView verify];
}

@end
