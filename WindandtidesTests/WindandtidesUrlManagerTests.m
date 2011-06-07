//
//  UrlManagerTests.m
//  Windandtides
//
//  Created by Todd Huss on 6/6/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>
#import "WindandtidesUrlManager.h"

@interface WindandtidesUrlManagerTests: SenTestCase {}
@end

WindandtidesUrlManager *urlManager;

@implementation WindandtidesUrlManagerTests


- (void)setUp {
    [super setUp];
    urlManager = [[WindandtidesUrlManager alloc] init];
}

- (void)tearDown {
    [urlManager release];
    [super tearDown];
}

- (void)testConstantsExist {        
    NSNumber* (^constant)(int) = ^(int i) { return [NSNumber numberWithInt:i]; };
    assertThat(constant(kForecast), equalTo(constant(0)));
    assertThat(constant(kTidesAndCurrents), equalTo(constant(1)));
    assertThat(constant(kAngelIslandWinds), equalTo(constant(2)));
    assertThat(constant(kGoldenGateWinds), equalTo(constant(3)));    
}

- (void)testUrlsExistForConstants {
    assertThat([urlManager urlFor:kForecast], startsWith(@"http://"));
    assertThat([urlManager urlFor:kTidesAndCurrents], startsWith(@"http://"));
    assertThat([urlManager urlFor:kAngelIslandWinds], startsWith(@"http://"));
    assertThat([urlManager urlFor:kGoldenGateWinds], startsWith(@"http://"));    
}

@end
