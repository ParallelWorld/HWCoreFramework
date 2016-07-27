//
//  SLAppDelegate.m
//  HWCoreFramework
//
//  Created by ParallelWorld on 06/13/2016.
//  Copyright (c) 2016 ParallelWorld. All rights reserved.
//

#import "AppDelegate.h"
#import "SLRootController.h"


@interface SLUser : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@end
@implementation SLUser
HW_CODING_IMPLEMENTATION
@end


@interface AppDelegate ()
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SLRootController *root = [SLRootController new];
    [root setupAllChildViewControllers];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    
    // test cache
    [self testCache];
    return YES;
}

- (void)testCache {
    SLUser *user = [SLUser new];
    user.name = @"lalala";
    NSString *key = @"user1";
    HWCache *cache = [[HWCache alloc] initWithName:@"paralleWorld"];
    [cache setObject:user forKey:key];
    [cache removeObjectForKey:key];
    
    SLUser *cacheUser = [cache objectForKey:key];
    SLUser *memoryCacheUser = [cache.memoryCache objectForKey:key];
    SLUser *diskCacheUser = [cache.diskCache objectForKey:key];
    HW_LOG_VAR(nil);
}

@end
