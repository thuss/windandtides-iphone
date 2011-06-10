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

@property(nonatomic, retain) NSDictionary *pages;

@end

@implementation WindandtidesUrlManager

@synthesize pages = _pages;

- (void)dealloc {
    [_pages release];
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *(^url)(NSString *) = ^(NSString *uri) { 
            return (NSString *)[NSString stringWithFormat:@"http://windandtides.com%@", uri]; 
        };
        self.pages = [NSDictionary dictionaryWithObjectsAndKeys:
                url(@"/marine/forecast"), NUM(kForecast),
                url(@"/marine/tide"), NUM(kTidesAndCurrents),
                url(@"/marine/wind/Angel+Island"), NUM(kAngelIslandWinds),
                url(@"/marine/wind/Golden+Gate"), NUM(kGoldenGateWinds),
                nil];
    }
    return self;
}

- (NSString *)urlFor:(WindandtidesPages)page {
    return [self.pages objectForKey:[NSNumber numberWithInt:page]];
}

@end
