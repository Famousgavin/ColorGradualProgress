//
//  ViewController.m
//  ColorGradualProgress
//
//  Created by dhuil on 15/9/12.
//  Copyright (c) 2015年 Gavin Li. All rights reserved.
//
#import "GradualProgressView.h"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];

    GradualProgressView * gradualProgressView = [[GradualProgressView alloc] initWithFrame:CGRectMake(0., 64., self.view.frame.size.width, 2.0)];
    [self.view addSubview:gradualProgressView];
    
    [self performSelector:@selector(gradualProgressWithView:) withObject:gradualProgressView afterDelay:5.];

   
}


- (void)gradualProgressWithView:(GradualProgressView *)gradualProgressView
{
    gradualProgressView.progress += 0.1;
   
    if (gradualProgressView.progress == 1.0)
    {
        return;
    }
    [self performSelector:@selector(gradualProgressWithView:) withObject:gradualProgressView afterDelay:0.3];


}


@end
