
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <pthread.h>
#import <mach/mach_time.h>


#ifndef HWUtilsMacro_h
#define HWUtilsMacro_h

#pragma mark - Transform

#define HW_TOSTRING(var) [NSString stringWithFormat:@"%@", hw_box(@encode(__typeof__((var))), (var))]


#pragma mark - Singleton

#define HW_SINGLETON_INTERFACE(className) \
+ (instancetype)shared##className##Instance;

#define HW_SINGLETON_IMPLEMENTATION(className) \
static className *_instanceOf##className; \
+ (id)allocWithZone:(NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instanceOf##className = [super allocWithZone:zone]; \
    }); \
    return _instanceOf##className; \
} \
+ (instancetype)shared##className##Instance { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instanceOf##className = [[self alloc] init]; \
    }); \
    return _instanceOf##className; \
}


#pragma mark - Log

#ifdef DEBUG
#define HW_LOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define HW_LOG_VAR(var) HW_LOG(@"%@", hw_box(@encode(__typeof__((var))), (var)))
#else
#define HW_LOG(...)
#define HW_LOG_VAR(var)
#endif


#pragma mark - Strong & weak reference

#define HW_WEAKIFY(object) __weak __typeof__(object) weak##_##object = object;
#define HW_STRONGIFY(object) __typeof__(object) object = weak##_##object;


#pragma mark - NSObject coding

#define HW_CODING_IMPLEMENTATION \
- (instancetype)initWithCoder:(NSCoder *)aDecoder { \
    self = [super init]; \
    if (self) { \
        [self hw_decode:aDecoder]; \
    } \
    return self; \
} \
- (void)encodeWithCoder:(NSCoder *)aCoder { \
    [self hw_encode:aCoder]; \
}


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


#pragma mark - Declaration & definition

#define HW_DECLARATION(v) FOUNDATION_EXTERN NSString *const v
#define HW_DEFINITION(v) NSString *const v = @#v


#pragma mark - Static inline C function

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

static inline id hw_box(const char * type, ...)
{
    va_list variable_param_list;
    va_start(variable_param_list, type);
    
    id object = nil;
    
    if (strcmp(type, @encode(id)) == 0) {
        id param = va_arg(variable_param_list, id);
        object = param;
    }
    else if (strcmp(type, @encode(CGPoint)) == 0) {
        CGPoint param = (CGPoint)va_arg(variable_param_list, CGPoint);
        object = [NSValue valueWithCGPoint:param];
    }
    else if (strcmp(type, @encode(CGSize)) == 0) {
        CGSize param = (CGSize)va_arg(variable_param_list, CGSize);
        object = [NSValue valueWithCGSize:param];
    }
    else if (strcmp(type, @encode(CGVector)) == 0) {
        CGVector param = (CGVector)va_arg(variable_param_list, CGVector);
        object = [NSValue valueWithCGVector:param];
    }
    else if (strcmp(type, @encode(CGRect)) == 0) {
        CGRect param = (CGRect)va_arg(variable_param_list, CGRect);
        object = [NSValue valueWithCGRect:param];
    }
    else if (strcmp(type, @encode(NSRange)) == 0) {
        NSRange param = (NSRange)va_arg(variable_param_list, NSRange);
        object = [NSValue valueWithRange:param];
    }
    else if (strcmp(type, @encode(CFRange)) == 0) {
        CFRange param = (CFRange)va_arg(variable_param_list, CFRange);
        object = [NSValue value:&param withObjCType:type];
    }
    else if (strcmp(type, @encode(CGAffineTransform)) == 0) {
        CGAffineTransform param = (CGAffineTransform)va_arg(variable_param_list, CGAffineTransform);
        object = [NSValue valueWithCGAffineTransform:param];
    }
    else if (strcmp(type, @encode(CATransform3D)) == 0) {
        CATransform3D param = (CATransform3D)va_arg(variable_param_list, CATransform3D);
        object = [NSValue valueWithCATransform3D:param];
    }
    else if (strcmp(type, @encode(SEL)) == 0) {
        SEL param = (SEL)va_arg(variable_param_list, SEL);
        object = NSStringFromSelector(param);
    }
    else if (strcmp(type, @encode(Class)) == 0) {
        Class param = (Class)va_arg(variable_param_list, Class);
        object = NSStringFromClass(param);
    }
    else if (strcmp(type, @encode(UIOffset)) == 0) {
        UIOffset param = (UIOffset)va_arg(variable_param_list, UIOffset);
        object = [NSValue valueWithUIOffset:param];
    }
    else if (strcmp(type, @encode(UIEdgeInsets)) == 0) {
        UIEdgeInsets param = (UIEdgeInsets)va_arg(variable_param_list, UIEdgeInsets);
        object = [NSValue valueWithUIEdgeInsets:param];
    }
    else if (strcmp(type, @encode(short)) == 0) {
        short param = (short)va_arg(variable_param_list, int);
        object = @(param);
    }
    else if (strcmp(type, @encode(int)) == 0) {
        int param = (int)va_arg(variable_param_list, int);
        object = @(param);
    }
    else if (strcmp(type, @encode(long)) == 0) {
        long param = (long)va_arg(variable_param_list, long);
        object = @(param);
    }
    else if (strcmp(type, @encode(long long)) == 0) {
        long long param = (long long)va_arg(variable_param_list, long long);
        object = @(param);
    }
    else if (strcmp(type, @encode(float)) == 0) {
        float param = (float)va_arg(variable_param_list, double);
        object = @(param);
    }
    else if (strcmp(type, @encode(double)) == 0) {
        double param = (double)va_arg(variable_param_list, double);
        object = @(param);
    }
    else if (strcmp(type, @encode(BOOL)) == 0) {
        BOOL param = (BOOL)va_arg(variable_param_list, int);
        object = param ? @"YES" : @"NO";
    }
    else if (strcmp(type, @encode(bool)) == 0) {
        bool param = (bool)va_arg(variable_param_list, int);
        object = param ? @"true" : @"false";
    }
    else if (strcmp(type, @encode(char)) == 0) {
        char param = (char)va_arg(variable_param_list, int);
        object = [NSString stringWithFormat:@"%c", param];
    }
    else if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short param = (unsigned short)va_arg(variable_param_list, unsigned int);
        object = @(param);
    }
    else if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int param = (unsigned int)va_arg(variable_param_list, unsigned int);
        object = @(param);
    }
    else if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long param = (unsigned long)va_arg(variable_param_list, unsigned long);
        object = @(param);
    }
    else if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long param = (unsigned long long)va_arg(variable_param_list, unsigned long long);
        object = @(param);
    }
    else if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char param = (unsigned char)va_arg(variable_param_list, unsigned int);
        object = [NSString stringWithFormat:@"%c", param];
    }
    else {
        void * param = (void *)va_arg(variable_param_list, void *);
        object = [NSString stringWithFormat:@"%p", param];
    }
    
    va_end(variable_param_list);
    
    return object;
}

static inline CGFloat hw_printBlockRuntime(NSString *identifier, NSUInteger times, void (^block)()) {
    mach_timebase_info_data_t info;
    CGFloat duration = -1;
    if (mach_timebase_info(&info) == KERN_SUCCESS) {
        uint64_t start = mach_absolute_time();
        for (NSUInteger i = 0; i < times; i++) {
            block();
        }
        uint64_t end = mach_absolute_time();
        uint64_t elapsed = end - start;
        uint64_t nanos = elapsed * info.numer / info.denom;
        duration = (CGFloat)nanos / NSEC_PER_MSEC;
    }
    NSLog(@"%@: %@ms", identifier, @(duration));
    return duration;
}


#endif
