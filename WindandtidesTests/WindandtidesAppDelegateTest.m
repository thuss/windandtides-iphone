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

- (void)testForWindandtidesAppDelegate { 
    assertThat([appDelegate class], equalTo([WindandtidesAppDelegate class]));    
}

@end
