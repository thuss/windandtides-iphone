//
//  AnimatedSwipeGestures.h
//  Windandtides
//
//  Created by Todd Huss on 6/7/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AnimatedSwipeGestures : NSObject {
}

- (void)didSwipeLeft:(UISwipeGestureRecognizer *)recognizer;
- (void)didSwipeRight:(UISwipeGestureRecognizer *)recognizer;

@end
