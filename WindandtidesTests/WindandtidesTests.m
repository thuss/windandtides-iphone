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

@interface WindandtidesTests : SenTestCase {}
@end

@implementation WindandtidesTests

- (void)setUp {
    [super setUp];
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.    
    [super tearDown];
}

- (void)testExample {
    assertThat(@"foo", equalTo(@"foo"));
}

@end
