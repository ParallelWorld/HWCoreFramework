//
//  SLAppDelegate.m
//  HWCoreFramework
//
//  Created by ParallelWorld on 06/13/2016.
//  Copyright (c) 2016 ParallelWorld. All rights reserved.
//

#import "AppDelegate.h"
#import "SLTestViewController.h"


@interface AppDelegate ()
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SLTestViewController *root = [SLTestViewController new];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:root];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
