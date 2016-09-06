
#import "UIScreen+HWAdd.h"

@implementation UIScreen (HWAdd)

+ (CGFloat)hw_screenScale {
    static CGFloat screenScale = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSThread isMainThread]) {
            screenScale = [UIScreen mainScreen].scale;
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                screenScale = [UIScreen mainScreen].scale;
            });
        }
    });
    return screenScale;
}

@end
