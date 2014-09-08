//
//  LLAViewController.m
//  LLARingSpinnerView
//
//  Created by Lukas Lipka on 19/07/14.
//  Copyright (c) 2014 Lukas Lipka. All rights reserved.
//

#import "LLAViewController.h"
#import <LLARingSpinnerView/LLARingSpinnerView.h>

@interface LLAViewController ()

@end

@implementation LLAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [LLARingSpinnerView addOverlayRingSpinnerToView:self.view];
}

@end
