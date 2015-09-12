//
//  GradualProgressView.h
//  ColorGradualProgress
//
//  Created by dhuil on 15/9/12.
//  Copyright (c) 2015年 Gavin Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradualProgressView : UIView


/**  Progress values go from 0.0 to 1.0  */
@property (nonatomic, assign) CGFloat progress;


/**  init  */
- (instancetype)initWithFrame:(CGRect )frame;


@end
