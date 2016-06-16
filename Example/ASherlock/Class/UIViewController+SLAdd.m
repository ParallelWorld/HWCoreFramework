//
//  UIViewController+SLAdd.m
//  HWCoreFramework
//
//  Created by 58 on 6/14/16.
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
        NSString *className = NSStringFromClass([vc class]);
        
        // 此处写的原因是如果设置背景色会造成UITabBarController显示异常
        if (![className hasPrefix:@"UI"]) {
            vc.view.backgroundColor = [UIColor whiteColor];
        }
        
        // NavigationBar
        vc.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        vc.navigationController.navigationBar.translucent = NO;
    } error:NULL];
}

@end
