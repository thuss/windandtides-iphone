//
//  WindandtidesUrlManager.m
//  Windandtides
//
//  Created by Todd Huss on 6/6/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import "WindandtidesUrlManager.h"

@interface WindandtidesUrlManager()

@property (nonatomic, retain) NSDictionary *pages;

@end

@implementation WindandtidesUrlManager

@synthesize pages=_pages;

-(void)dealloc {
    [_pages release];
    [super dealloc];
}

- (id) init {
    self = [super init];
    if (self) {        
        #define URL(uri) [NSString stringWithFormat:@"http://windandtides.com%@", uri]
        #define NUM(x) [NSNumber numberWithInt: x]        
        self.pages = [NSDictionary dictionaryWithObjectsAndKeys:
                      URL(@"/marine/forecast"), NUM(kForecast),
                      URL(@"/marine/tide"), NUM(kTidesAndCurrents),
                      URL(@"/marine/wind/Angel+Island"), NUM(kAngelIslandWinds),
                      URL(@"/marine/wind/Golden+Gate"), NUM(kGoldenGateWinds),                        
                      nil];
    }
    return self;
}

-(NSString *)urlFor:(WindandtidesPages)page {
    return [self.pages objectForKey:[NSNumber numberWithInt:page]];
}

@end
