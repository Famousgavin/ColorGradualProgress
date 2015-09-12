//
//  GradualProgressView.m
//  ColorGradualProgress
//
//  Created by dhuil on 15/9/12.
//  Copyright (c) 2015年 Gavin Li. All rights reserved.
//

#import "GradualProgressView.h"


@interface GradualProgressView ()

@property (nonatomic, strong) CALayer * maskLayer;

@end


@implementation GradualProgressView

/**  init  */
- (instancetype)initWithFrame:(CGRect )frame
{
    if ([super initWithFrame:frame])
    {
        CAGradientLayer * layer = (CAGradientLayer *)[self layer];
        [layer setStartPoint:CGPointMake(0.0, 0.5)];
        [layer setEndPoint:CGPointMake(1.0, 0.5)];
        
        NSMutableArray *colors = [NSMutableArray array];
        for (NSInteger hue = 0; hue <= 360; hue += 5)
        {
           UIColor * color = [UIColor colorWithHue:1.0 * hue / 360
                                        saturation:1.0
                                        brightness:1.0
                                             alpha:1.0];
            [colors addObject:(id)[color CGColor]];
        } 
        [layer setColors:[NSArray arrayWithArray:colors]];
        
        
        self.maskLayer = [CALayer layer];
        [self.maskLayer setFrame:CGRectMake(0.0, 0.0, 0.0, frame.size.height)];
        [self.maskLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
        [layer setMask:self.maskLayer];

        
        //Start the animation
        [self performAnimation];

    }
    return self;
}

+ (Class)layerClass
{
    return [CAGradientLayer class];
}


- (void)performAnimation
{
    CAGradientLayer * layer = (CAGradientLayer *)[self layer];
    NSMutableArray * colorArray = [[layer colors] mutableCopy];
    UIColor * lastColor = [colorArray lastObject];
    [colorArray removeLastObject];
    [colorArray insertObject:lastColor atIndex:0];
    NSArray * shiftedColors = [NSArray arrayWithArray:colorArray];
    
    [layer setColors:shiftedColors];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setToValue:shiftedColors];
    [animation setDuration:0.08];
    [animation setFillMode:kCAFillModeForwards];
    [animation setDelegate:self];
    [layer addAnimation:animation forKey:@"animateGradient"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    [self performAnimation];
}


- (void)setProgress:(CGFloat)value
{
    if (_progress != value)
    {
        _progress = MIN(1.0, fabs(value));
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    CGRect maskRect = [self.maskLayer frame];
    maskRect.size.width = CGRectGetWidth([self bounds]) * self.progress;
    [self.maskLayer setFrame:maskRect];
}




@end
