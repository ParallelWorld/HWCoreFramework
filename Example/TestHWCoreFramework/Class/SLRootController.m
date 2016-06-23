//
//  SLRootViewController.m
//  HWCoreFramework
//
//  Created by 58 on 6/14/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLRootController.h"
#import "SLHomeController.h"
#import "SLBidController.h"
#import "SLChatController.h"
#import "SLMineController.h"

@interface SLRootController ()

@end

@implementation SLRootController

- (void)setupAllChildViewControllers {
    UIViewController *homeVc = ({
        SLHomeController *vc = [SLHomeController new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav;
    });
    
    UIViewController *bidVc = ({
        SLBidController *vc = [SLBidController new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav;
    });
    
    UIViewController *chatVc = ({
        SLChatController *vc = [SLChatController new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav;
    });
    
    UIViewController *mineVc = ({
        SLMineController *vc = [SLMineController new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav;
    });
    
    self.tabBarItemsAttributes = @[@{CYLTabBarItemTitle : @"首页",
                                     CYLTabBarItemImage : [UIImage hw_imageName:@"ic_home"],
                                     CYLTabBarItemSelectedImage : [UIImage hw_imageName:@"ic_home_pressed"]},
                                   @{CYLTabBarItemTitle : @"发现",
                                     CYLTabBarItemImage : [UIImage hw_imageName:@"ic_bid"],
                                     CYLTabBarItemSelectedImage : [UIImage hw_imageName:@"ic_bid_pressed"]},
                                   @{CYLTabBarItemTitle : @"消息",
                                     CYLTabBarItemImage : [UIImage hw_imageName:@"ic_chat"],
                                     CYLTabBarItemSelectedImage : [UIImage hw_imageName:@"ic_chat_pressed"]},
                                   @{CYLTabBarItemTitle : @"我的",
                                     CYLTabBarItemImage : [UIImage hw_imageName:@"ic_mine"],
                                     CYLTabBarItemSelectedImage : [UIImage hw_imageName:@"ic_mine_pressed"]},];
    
    self.viewControllers = @[homeVc,
                             bidVc,
                             chatVc,
                             mineVc];
}

@end
