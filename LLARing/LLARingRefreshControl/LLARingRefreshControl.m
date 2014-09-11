//
//  LLARingRefreshControl.m
//  JackrabbitRefresh
//
//  Created by Ivan Vavilov on 9/8/14.
//  Copyright (c) 2014 Jackrabbit Mobile. All rights reserved.
//

#import "LLARingRefreshControl.h"
#import "LLARingSpinnerView.h"

static CGFloat const kRefreshControlEndAngle = 7 * M_PI / 8;
static CGFloat const kPullDistanceDivider = 60;

@interface LLARingRefreshControl()

@property (nonatomic, strong) LLARingSpinnerView *spinner;
@property (assign) BOOL isRefreshAnimating;

@end

@implementation LLARingRefreshControl

-(instancetype) init {
    if (self = [super init]) {
        self.tintColor = [UIColor clearColor];
        self.spinner = [LLARingSpinnerView addRingSpinnerToView:self
                                                          color:[UIColor colorWithRed:0.204 green:0.596 blue:0.856 alpha:1]];
        self.spinner.endAngle = 0;
        self.isRefreshAnimating = NO;
    }
    
    return self;
}

-(void)handleScroll {
    // Get the current size of the refresh controller
    CGRect refreshBounds = self.bounds;
    // Distance the table has been pulled >= 0
    CGFloat pullDistance = MAX(0.0, -self.frame.origin.y);
    // Set the encompassing view's frames
    refreshBounds.size.height = pullDistance;
    
    if (!self.isRefreshAnimating) {
        self.spinner.endAngle = MIN(pullDistance/kPullDistanceDivider * kRefreshControlEndAngle , kRefreshControlEndAngle);
    }
    
    // If we're refreshing and the animation is not playing, then play the animation
    if (self.isRefreshing && !self.isRefreshAnimating) {
        self.spinner.endAngle = kRefreshControlEndAngle;
        [self.spinner startAnimating];
        self.isRefreshAnimating = YES;
    }
    else if (!self.isRefreshing) {
        [self.spinner stopAnimating];
        self.isRefreshAnimating = NO;
    }
}

@end
