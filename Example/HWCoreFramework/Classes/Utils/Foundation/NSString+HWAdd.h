//
//  NSString+HWAdd.h
//  HWCoreFramework
//
//  Created by 58 on 6/23/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HWAdd)

/// Returns a lowercase NSString for md5 hash.
- (NSString *)hw_md5String;

/// Returns a lowercase NSString for sha1 hash.
- (NSString *)hw_sha1String;

/// Returns a string for base64 encoded.
- (NSString *)hw_base64EncodedString;

/// Returns a string from base64 encoded string.
+ (NSString *)hw_stringWithBase64EncodedString:(NSString *)base64EncodedString;

/// URL encode a string in utf-8.
- (NSString *)hw_stringByURLEncode;

/// URL decode s string in utf-8.
- (NSString *)hw_stringByURLDecode;

/// Returns the size of the string if it were rendered with the specified constraints.
- (CGSize)hw_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/// Returns the width of the string if it were to be rendered with the specified font on a single line.
- (CGFloat)hw_widthForFont:(UIFont *)font;

/// Returns the height of the string if it were rendered with the specified constraints.
- (CGFloat)hw_heightForFont:(UIFont *)font width:(CGFloat)width;

@end
