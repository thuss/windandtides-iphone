//
//  WindandtidesUrlManager.m
//  Windandtides
//
//  Created by Todd Huss on 6/6/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import "WindandtidesUrlManager.h"
#import "Macros.h"

@interface WindandtidesUrlManager ()

@property(nonatomic, strong) NSDictionary *pages;

- (NSString *)fullUrl:(NSString *)uri;

@end

@implementation WindandtidesUrlManager

@synthesize pages = _pages;


- (id)init {
    self = [super init];
    if (self) {
        self.pages = [NSDictionary dictionaryWithObjectsAndKeys:
                [self fullUrl:@"/marine/forecast"], NUM(kForecast),
                [self fullUrl:@"/marine/tide"], NUM(kTidesAndCurrents),
                [self fullUrl:@"/marine/wind/Angel+Island"], NUM(kAngelIslandWinds),
                [self fullUrl:@"/marine/wind/Golden+Gate"], NUM(kGoldenGateWinds),
                nil];
    }
    return self;
}

- (NSString *)fullUrl:(NSString *)uri {
    return (NSString *)[NSString stringWithFormat:@"http://windandtides.com%@", uri];
}

- (NSString *)urlFor:(WindandtidesPages)page {
    return [self.pages objectForKey:[NSNumber numberWithInt:page]];
}

@end
