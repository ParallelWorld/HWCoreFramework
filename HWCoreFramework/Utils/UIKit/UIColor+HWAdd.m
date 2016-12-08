
#import "UIColor+HWAdd.h"

@implementation UIColor (HWAdd)

+ (UIColor *)hw_randomColor {
    return [UIColor colorWithRed:arc4random() % 255 green:arc4random() % 255 blue:arc4random() % 255 alpha:1];
}

@end
