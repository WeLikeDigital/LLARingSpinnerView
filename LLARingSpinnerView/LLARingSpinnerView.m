//
//  LLARingSpinnerView.m
//  LLARingSpinnerView
//
//  Created by Lukas Lipka on 05/04/14.
//  Copyright (c) 2014 Lukas Lipka. All rights reserved.
//

#import "LLARingSpinnerView.h"

static NSString *kLLARingSpinnerAnimationKey = @"llaringspinnerview.rotation";
static CGFloat kSpinnerDefaultSize = 20;

@interface LLARingSpinnerView ()

@property (nonatomic, readonly) CAShapeLayer *progressLayer;
@property (nonatomic, readwrite) BOOL isAnimating;

@end

@implementation LLARingSpinnerView

@synthesize progressLayer = _progressLayer;
@synthesize isAnimating = _isAnimating;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect) frame
                          size:(CGFloat) size
                         color:(UIColor *) color {
    self = [self initWithFrame:frame];
    self.tintColor = color;
    self.bounds = CGRectMake(0, 0, size, size);
    return self;
}

- (instancetype) initWithFrame:(CGRect) frame
                         color:(UIColor *) color {
    self = [self initWithFrame:frame
                          size:kSpinnerDefaultSize
                         color:color];
    return self;
}

- (instancetype) initWithColor:(UIColor *) color {
    self = [self initWithFrame:CGRectZero
                          size:kSpinnerDefaultSize
                         color:color];
    return self;
}

- (void)initialize {
    [self.layer addSublayer:self.progressLayer];
}

+(instancetype)addRingSpinnerToView:(UIView *)view
                              color:(UIColor *) color {
    LLARingSpinnerView *spinner = [[self alloc] initWithFrame:CGRectZero
                                                         size:kSpinnerDefaultSize
                                                        color:color];
    spinner.center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    [view addSubview:spinner];
    [spinner startAnimating];
    return spinner;
}

+(instancetype)addRingSpinnerToView:(UIView *)view
                             center:(CGPoint)center
                              color:(UIColor *)color {
    LLARingSpinnerView *spinner = [[self alloc] initWithFrame:CGRectZero
                                                         size:kSpinnerDefaultSize
                                                        color:color];
    spinner.center = center;
    [view addSubview:spinner];
    [spinner startAnimating];
    return spinner;
}

+(instancetype)addRingSpinnerToView:(UIView *)view
                               size:(CGFloat)size
                              color:(UIColor *)color {
    LLARingSpinnerView *spinner = [[self alloc] initWithFrame:CGRectZero
                                                         size:size
                                                        color:color];
    spinner.center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    [view addSubview:spinner];
    [spinner startAnimating];
    return spinner;
}

+(instancetype)addRingSpinnerToView:(UIView *)view
                               size:(CGFloat)size
                             center:(CGPoint)center
                              color:(UIColor *)color {
    LLARingSpinnerView *spinner = [[self alloc] initWithFrame:CGRectZero
                                                         size:size
                                                        color:color];
    spinner.center = center;
    [view addSubview:spinner];
    [spinner startAnimating];
    return spinner;
}

+(BOOL)hideRingSpinnerForView:(UIView *)view {
    BOOL result = NO;
    LLARingSpinnerView *spinner = [self ringSpinnerForView:view];
    if (spinner != nil) {
        spinner.alpha = 0;
        [spinner removeFromSuperview];
        result = YES;
    }
    return result;
}

+(instancetype)ringSpinnerForView:(UIView *) view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (LLARingSpinnerView *)subview;
        }
    }
    return nil;
}

+(void) addOverlayRingSpinnerToView:(UIView *) view {
    LLARingSpinnerBackgroundView *background = [[LLARingSpinnerBackgroundView alloc] initWithFrame:CGRectMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds), 77, 77)];
    background.opaque = NO;
    
    [LLARingSpinnerView addRingSpinnerToView:background
                                        size:40 color:[UIColor grayColor]];
    [view addSubview:background];
}

+(void)hideOverlayRingSpinnerFromView:(UIView *)view {
    LLARingSpinnerBackgroundView *overlayRingSpinner = [self overlayRingSpinnerForView:view];
    
    if (overlayRingSpinner != nil) {
        overlayRingSpinner.alpha = 0;
        [overlayRingSpinner removeFromSuperview];
    }
}

+(LLARingSpinnerBackgroundView *) overlayRingSpinnerForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (LLARingSpinnerBackgroundView *)subview;
        }
    }
    return nil;
}


- (void) hide {
    self.alpha = 0;
    [self removeFromSuperview];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.progressLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    [self updatePath];
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    self.progressLayer.strokeColor = self.tintColor.CGColor;
}

- (void)startAnimating {
    if (self.isAnimating)
        return;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 1.0f;
    animation.fromValue = @(0.0f);
    animation.toValue = @(2 * M_PI);
    animation.repeatCount = INFINITY;
    
    [self.progressLayer addAnimation:animation forKey:kLLARingSpinnerAnimationKey];
    self.isAnimating = true;
}

- (void)stopAnimating {
    if (!self.isAnimating)
        return;
    
    [self.progressLayer removeAnimationForKey:kLLARingSpinnerAnimationKey];
    self.isAnimating = false;
}

#pragma mark - Private

- (void)updatePath {
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = MIN(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - self.progressLayer.lineWidth / 2;
    CGFloat startAngle = 0;
    CGFloat endAngle = (CGFloat)(3 * M_PI_2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.progressLayer.path = path.CGPath;
}

#pragma mark - Properties

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.strokeColor = self.tintColor.CGColor;
        _progressLayer.fillColor = nil;
        _progressLayer.lineWidth = 1.5f;
    }
    return _progressLayer;
}

- (BOOL)isAnimating {
    return _isAnimating;
}

- (CGFloat)lineWidth {
    return self.progressLayer.lineWidth;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    self.progressLayer.lineWidth = lineWidth;
    [self updatePath];
}

@end

@implementation LLARingSpinnerBackgroundView

-(void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    CGContextSetGrayFillColor(context, 0.0f, 0.8);
    
    CGRect boxRect = self.bounds;
    float radius = 10;
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect));
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * (float)M_PI / 2, 0, 0);
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMaxY(boxRect) - radius, radius, 0, (float)M_PI / 2, 0);
    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, (float)M_PI / 2, (float)M_PI, 0);
    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect) + radius, radius, (float)M_PI, 3 * (float)M_PI / 2, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    UIGraphicsPopContext();
}

@end
