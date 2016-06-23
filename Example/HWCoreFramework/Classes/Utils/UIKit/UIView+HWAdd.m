//
//  UIView+HWAdd.m
//  HWCoreFramework
//
//  Created by 58 on 6/16/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "UIView+HWAdd.h"

@implementation UIView (HWAdd)

+ (void)hw_dismissKeyboard {
    // http://stackoverflow.com/questions/741185/easy-way-to-dismiss-keyboard
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)hw_removeAllSubviews {
    while (self.subviews.count != 0) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (UIViewController *)hw_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)hw_left {
    return self.frame.origin.x;
}

- (void)setHw_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)hw_top {
    return self.frame.origin.y;
}

- (void)setHw_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)hw_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setHw_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)hw_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setHw_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)hw_width {
    return self.frame.size.width;
}

- (void)setHw_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)hw_height {
    return self.frame.size.height;
}

- (void)setHw_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)hw_centerX {
    return self.center.x;
}

- (void)setHw_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)hw_centerY {
    return self.center.y;
}

- (void)setHw_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)hw_origin {
    return self.frame.origin;
}

- (void)setHw_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)hw_size {
    return self.frame.size;
}

- (void)setHw_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
