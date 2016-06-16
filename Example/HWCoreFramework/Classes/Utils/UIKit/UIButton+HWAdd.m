//
//  UIButton+HWAdd.m
//  HWCoreFramework
//
//  Created by 58 on 6/16/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "UIButton+HWAdd.h"

@implementation UIButton (HWAdd)

- (void)hw_setBackgroundColor:(UIColor *)color forState:(UIControlState)state
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:image forState:state];
}

@end
