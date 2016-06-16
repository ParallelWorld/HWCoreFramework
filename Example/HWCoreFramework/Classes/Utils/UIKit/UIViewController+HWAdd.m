//
//  UIViewController+HWAdd.m
//  HWCoreFramework
//
//  Created by 58 on 6/16/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "UIViewController+HWAdd.h"

@implementation UIViewController (HWAdd)

- (void)hw_backToLast {
    if (self.navigationController) {
        if ([self.navigationController.viewControllers count] == 1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
