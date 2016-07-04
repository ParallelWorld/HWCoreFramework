//
//  SLAppDelegate.m
//  HWCoreFramework
//
//  Created by ParallelWorld on 06/13/2016.
//  Copyright (c) 2016 ParallelWorld. All rights reserved.
//

#import "AppDelegate.h"
#import "SLRootController.h"

typedef enum {
    SexMale,
    SexFemale
} Sex;


@interface Father : NSObject
@property (nonatomic, copy) NSString *name;
@end
@implementation Father
HW_CODING_IMPLEMENTATION
@end

@interface User : NSObject

/** 名称 */
@property (copy, nonatomic) NSString *name;
/** 头像 */
@property (copy, nonatomic) NSString *icon;
/** 年龄 */
@property (assign, nonatomic) unsigned int age;
/** 身高 */
@property (copy, nonatomic) NSString *height;
/** 财富 */
@property (strong, nonatomic) NSNumber *money;
/** 性别 */
@property (assign, nonatomic) Sex sex;
/** 同性恋 */
@property (assign, nonatomic, getter=isGay) BOOL gay;

@property (nonatomic, strong) Father *father;

@property (nonatomic, strong) NSArray *mothers;

@end

@implementation User

HW_CODING_IMPLEMENTATION

+ (NSDictionary *)hw_modelContainerPropertyGenericClass {
    return @{@"mothers": @"Father"};
}

+ (NSDictionary *)hw_modelCustomPropertyMapper {
    return @{@"name" : @"n"};
}

@end



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    SLRootController *root = [SLRootController new];
    [root setupAllChildViewControllers];

    self.window.rootViewController = root;

    [self.window makeKeyAndVisible];
    
    NSDictionary *dict = @{
                           @"n" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @(20),
                           @"height" : @1.55,
                           @"money" : @"100.9",
                           @"sex" : @(SexFemale),
                           @"gay" : @"1",
                           @"father" : @{@"name" : @"fa"},
                           @"mothers" : @[@{@"name" : @"m1"},
                                          @{@"name" : @"m2"},
                                          @{@"name" : @"m3"}]
                           };
    User *u = [User hw_modelWithDictionary:dict];
    
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path  = [docPath stringByAppendingPathComponent:@"data.archiver"];
    BOOL flag = [NSKeyedArchiver archiveRootObject:u toFile:path];
    
    HW_LOG_VAR(flag);
    
    User *newUser = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    HW_LOG_VAR(newUser);
    
    HW_LOG_VAR(u);
    return YES;
}

@end
