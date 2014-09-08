//
//  LLARingSpinnerView.h
//  LLARingSpinnerView
//
//  Created by Lukas Lipka on 05/04/14.
//  Copyright (c) 2014 Lukas Lipka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLARingSpinnerView : UIView

@property (nonatomic, readonly) BOOL isAnimating;
@property (nonatomic) CGFloat lineWidth;


- (instancetype) initWithFrame:(CGRect) frame
                          size:(CGFloat) size
                         color:(UIColor *) color;

- (instancetype) initWithFrame:(CGRect) frame
                         color:(UIColor *) color;

- (instancetype) initWithColor:(UIColor *) color;

+ (instancetype) addRingSpinnerToView:(UIView *) view
                                color:(UIColor *) color;

+ (instancetype) addRingSpinnerToView:(UIView *) view
                               center:(CGPoint) center
                                color:(UIColor *) color;

+ (instancetype) addRingSpinnerToView:(UIView *) view
                               size:(CGFloat) size
                                color:(UIColor *) color;

+ (instancetype) addRingSpinnerToView:(UIView *) view
                                 size:(CGFloat) size
                               center:(CGPoint) center
                                color:(UIColor *) color;

+ (BOOL) hideRingSpinnerForView:(UIView *) view;

- (void) startAnimating;
- (void) stopAnimating;
- (void) hide;

@end
