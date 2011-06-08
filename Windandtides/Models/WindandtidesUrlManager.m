//
//  WindandtidesUrlManager.m
//  Windandtides
//
//  Created by Todd Huss on 6/6/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import "WindandtidesUrlManager.h"

NSDictionary *pageUrlDict;

@implementation WindandtidesUrlManager

-(void)dealloc {
    [pageUrlDict release];
    [super dealloc];
}

- (id) init {
    self = [super init];
    if (self) {
        pageUrlDict = [[NSDictionary dictionaryWithObjectsAndKeys:
                        @"http://windandtides.com/marine/forecast", 
                        [NSNumber numberWithInt:kForecast],
                        @"http://windandtides.com/marine/tide", 
                        [NSNumber numberWithInt:kTidesAndCurrents],
                        @"http://windandtides.com/marine/wind/Angel+Island", 
                        [NSNumber numberWithInt:kAngelIslandWinds],
                        @"http://windandtides.com/marine/wind/Golden+Gate", 
                        [NSNumber numberWithInt:kGoldenGateWinds],                        
                        nil] retain];
    }
    return self;
}

-(NSString *)urlFor:(WindandtidesPages)page {
    return [pageUrlDict objectForKey:[NSNumber numberWithInt:page]];
}

@end
