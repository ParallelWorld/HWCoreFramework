//
//  UIViewController+SLAdd.m
//  HWCoreFramework
//
//  Created by 58 on 6/21/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "UIViewController+SLAdd.h"
#import "Aspects.h"

@implementation UIViewController (SLAdd)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self sl_hookController];
    });
}

+ (void)sl_hookController {
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
        UIViewController *vc = [info instance];
        
        if ([NSStringFromClass(vc.class) hasPrefix:@"SL"]) {
            vc.view.backgroundColor = kSLMainBackgroundColor;
        }
        
        [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
        [UINavigationBar appearance].translucent = NO;
        
        [UITabBar appearance].tintColor = kSLMainColor;
    } error:NULL];
}

@end
