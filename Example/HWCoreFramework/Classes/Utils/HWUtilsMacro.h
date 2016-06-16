//
//  HWUtilsMacro.h
//  HWCoreFramework
//
//  Created by 58 on 6/15/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <pthread.h>


#ifndef HWUtilsMacro_h
#define HWUtilsMacro_h


#pragma mark - 单例

#define HW_SINGLETON_INTERFACE(className) \
+ (instancetype)sharedInstance;

#define HW_SINGLETON_IMPLEMENTATION(className) \
static className *_instanceOf##className; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instanceOf##className = [super allocWithZone:zone]; \
}); \
return _instanceOf##className; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instanceOf##className = [[self alloc] init]; \
}); \
return _instanceOf##className; \
}


#pragma mark - LOG

#ifdef DEBUG
#define HW_LOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define HW_LOG(...)
#endif


#pragma mark - 强引用，弱引用

#define HW_WEAKIFY(object) __weak __typeof__(object) weak##_##object = object;
#define HW_STRONGIFY(object) __typeof__(object) object = weak##_##object;


#pragma mark - UIScreen

#define HW_SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define HW_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define HW_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#pragma mark - UIColor

#define HW_COLOR_RGB(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]
#define HW_COLOR_RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HW_COLOR_HEX(v) [UIColor colorWithRed:(((v)&0xFF0000)>>16)/255.0 green:(((v)&0xFF00)>>8)/255.0 blue:((v)&0xFF)/255.0 alpha:1.0]
#define HW_COLOR_HEXA(v, a) [UIColor colorWithRed:(((v)&0xFF0000)>>16)/255.0 green:(((v)&0xFF00)>>8)/255.0 blue:((v)&0xFF)/255.0 alpha:(a)]


#pragma mark - UIDevice

#define HW_SYSTEM_VERSION [[UIDevice currentDevice].systemVersion doubleValue]
#define HW_SYSTEM_VERSION_LESS_THAN(v) ([[UIDevice currentDevice].systemVersion doubleValue] <= v)
#define HW_SYSTEM_VERSION_MORE_THAN(v) ([[UIDevice currentDevice].systemVersion doubleValue] >= v)


#pragma mark - NSNotification

#define HW_NOTIFICATION_DECLARATION(n) extern NSString *const n;
#define HW_NOTIFICATION_DEFINITION(n) NSString *const n = @#n;


#pragma mark - static inline C function

static inline bool hw_dispatch_is_main_queue() {
    return pthread_main_np() != 0;
}

static inline void hw_dispatch_async_on_main_queue(void (^block)()) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

static inline void hw_dispatch_async_on_global_queue(void (^block)()) {
    if (pthread_main_np()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
    } else {
        block();
    }
}


#endif /* HWUtilsMacro_h */
