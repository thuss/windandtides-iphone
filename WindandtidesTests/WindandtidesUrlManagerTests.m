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
#import "Macros.h"

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
    assertThat(NUM(kForecast), equalTo(NUM(0)));
    assertThat(NUM(kTidesAndCurrents), equalTo(NUM(1)));
    assertThat(NUM(kAngelIslandWinds), equalTo(NUM(2)));
    assertThat(NUM(kGoldenGateWinds), equalTo(NUM(3)));    
}

- (void)testUrlsExistForConstants {
    assertThat([urlManager urlFor:kForecast], startsWith(@"http://"));
    assertThat([urlManager urlFor:kTidesAndCurrents], startsWith(@"http://"));
    assertThat([urlManager urlFor:kAngelIslandWinds], startsWith(@"http://"));
    assertThat([urlManager urlFor:kGoldenGateWinds], startsWith(@"http://"));    
}

@end
