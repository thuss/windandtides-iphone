//
//  AnimatedSwipeGestures.m
//  Windandtides
//
//  Created by Todd Huss on 6/7/11.
//  Copyright 2011 Windandtides.com. All rights reserved.
//

#import "AnimatedSwipeGestures.h"

@interface AnimatedSwipeGestures ()

@property(nonatomic, unsafe_unretained) UITabBarController *controller;
@property(nonatomic, strong) UISwipeGestureRecognizer *recognizerLeft;
@property(nonatomic, strong) UISwipeGestureRecognizer *recognizerRight;

typedef enum {
    kAnimateLeft,
    kAnimateRight
} AnimationDirection;

- (void)addSwipeGestureRecognizers;

- (void)animateSwipe:(int)newTabIndex withDirection:(AnimationDirection)direction;

@end

@implementation AnimatedSwipeGestures

- (id)initWithController:(UITabBarController *)controller {
    self = [super init];
    if (self) {
        self.controller = controller;
        [self addSwipeGestureRecognizers];
    }
    return self;
}

- (void)dealloc {
    // view and controller aren't retained, no need to release
    [self.controller.view removeGestureRecognizer:self.recognizerLeft];
    [self.controller.view removeGestureRecognizer:self.recognizerRight];
}

- (void)addSwipeGestureRecognizers {
    self.recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
    self.recognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.controller.view addGestureRecognizer:self.recognizerLeft];

    self.recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    self.recognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.controller.view addGestureRecognizer:self.recognizerRight];
}

- (void)didSwipeRight:(UISwipeGestureRecognizer *)recognizer {
    int newTabIndex = (([self.controller selectedIndex] + 3) % 4);
    [self animateSwipe:newTabIndex withDirection:kAnimateLeft];
}

- (void)didSwipeLeft:(UISwipeGestureRecognizer *)recognizer {
    int newTabIndex = (([self.controller selectedIndex] + 1) % 4);
    [self animateSwipe:newTabIndex withDirection:kAnimateRight];
}

- (void)animateSwipe:(int)newTabIndex withDirection:(AnimationDirection)direction {
    // Get the views.
    UIView *fromView = self.controller.selectedViewController.view;
    UIView *toView = [[self.controller.viewControllers objectAtIndex:newTabIndex] view];
    // Get the size of the view area.
    CGRect viewSize = fromView.frame;
    // Add the to view to the tab bar view.
    [fromView.superview addSubview:toView];
    // Position it off screen.
    toView.frame = CGRectMake((direction == kAnimateRight ? 320 : -320), viewSize.origin.y, 320, viewSize.size.height);
    // Run the animation
    [UIView animateWithDuration:0.3
                     animations:^{
                         // Animate the views on and off the screen. This will appear to slide.
                         fromView.frame = CGRectMake((direction == kAnimateRight ? -320 : 320), viewSize.origin.y, 320, viewSize.size.height);
                         toView.frame = CGRectMake(0, viewSize.origin.y, 320, viewSize.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             // Remove the old view from the tabbar view.
                             [fromView removeFromSuperview];
                             self.controller.selectedIndex = newTabIndex;
                         }
                     }];
}


@end
