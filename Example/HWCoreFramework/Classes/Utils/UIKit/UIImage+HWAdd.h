
#import <UIKit/UIKit.h>

@interface UIImage (HWAdd)

+ (UIImage *)hw_imageName:(NSString *)name;

+ (UIImage *)hw_imageWithColor:(UIColor *)color;

+ (UIImage *)hw_imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)hw_imageWithCornerRadius:(CGFloat)radius;

- (UIImage *)hw_imageWithCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor;

- (UIImage *)hw_imageWithCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin;

+ (UIImage *)hw_imageWithData:(NSData *)data;

@end
