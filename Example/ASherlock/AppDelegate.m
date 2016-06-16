//
//  SLAppDelegate.m
//  HWCoreFramework
//
//  Created by ParallelWorld on 06/13/2016.
//  Copyright (c) 2016 ParallelWorld. All rights reserved.
//

#import "AppDelegate.h"
#import "SLRootController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    SLRootController *root = [SLRootController new];
    [root setupAllChildViewControllers];

    self.window.rootViewController = root;

    [self.window makeKeyAndVisible];
    return YES;
}

@end
