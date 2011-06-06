//
//  WindandtidesUrlManager.h
//  Windandtides
//
//  Created by Todd Huss on 6/6/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WindandtidesUrlManager : NSObject { }

typedef enum { 
    kForecast, 
    kTidesAndCurrents,
    kAngelIslandWinds,
    kGoldenGateWinds
} WindandtidesPages;  

-(NSString *)urlFor:(WindandtidesPages)page;

@end
