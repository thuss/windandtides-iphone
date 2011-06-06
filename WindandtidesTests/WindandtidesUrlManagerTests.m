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
    NSNumber* (^number)(int) = ^(int i) { return [NSNumber numberWithInt:i]; };
    assertThat(number(kForecast), equalTo(number(0)));
    assertThat(number(kTidesAndCurrents), equalTo(number(1)));
    assertThat(number(kAngelIslandWinds), equalTo(number(2)));
    assertThat(number(kGoldenGateWinds), equalTo(number(3)));    
}

- (void)testUrlsExistForConstants {
    assertThat([urlManager urlFor:kForecast], startsWith(@"http://"));
    assertThat([urlManager urlFor:kTidesAndCurrents], startsWith(@"http://"));
    assertThat([urlManager urlFor:kAngelIslandWinds], startsWith(@"http://"));
    assertThat([urlManager urlFor:kGoldenGateWinds], startsWith(@"http://"));    
}

@end
