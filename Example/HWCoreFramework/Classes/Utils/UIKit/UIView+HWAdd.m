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

@end
