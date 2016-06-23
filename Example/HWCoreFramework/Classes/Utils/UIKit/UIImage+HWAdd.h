//
//  UIImage+HWAdd.h
//  Pods
//
//  Created by 58 on 6/14/16.
//
//

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

@end
