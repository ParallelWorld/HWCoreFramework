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
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                      image:[UIImage hw_imageName:@"ic_home"]
                                              selectedImage:[UIImage hw_imageName:@"ic_home_pressed"]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav;
    });
    
    UIViewController *bidVc = ({
        SLBidController *vc = [SLBidController new];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现"
                                                      image:[UIImage hw_imageName:@"ic_bid"]
                                              selectedImage:[UIImage hw_imageName:@"ic_bid_pressed"]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav;
    });
    
    UIViewController *chatVc = ({
        SLChatController *vc = [SLChatController new];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息"
                                                      image:[UIImage hw_imageName:@"ic_chat"]
                                              selectedImage:[UIImage hw_imageName:@"ic_chat_pressed"]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav;
    });
    
    UIViewController *mineVc = ({
        SLMineController *vc = [SLMineController new];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                      image:[UIImage hw_imageName:@"ic_mine"]
                                              selectedImage:[UIImage hw_imageName:@"ic_mine_pressed"]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav;
    });
    
    self.viewControllers = @[homeVc,
                             bidVc,
                             chatVc,
                             mineVc];
}

@end
