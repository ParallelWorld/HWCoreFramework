
#import <Foundation/Foundation.h>

@interface NSData (HWAdd)

#pragma mark - Hash

/// Returns a lowercase NSString for md5 hash.
- (NSString *)hw_md5String;

/// Returns an NSData for md5 hash.
- (NSData *)hw_md5Data;

/// Returns a lowercase NSString for sha1 hash.
- (NSString *)hw_sha1String;

/// Returns an NSData for sha1 hash.
- (NSData *)hw_sha1Data;

#pragma mark - Encode and decode

/// Returns string decoded in UTF8.
- (NSString *)hw_utf8String;

/// Returns string for base64 encoded.
- (NSString *)hw_base64EncodedString;

/// Returns NSData from base64 encoded string.
+ (NSData *)hw_dataWithBase64EncodedString:(NSString *)base64EncodedString;

#pragma mark - Image Content Type

/// Returns the content type as string for an image data, such as image/jpeg, image/gif.
+ (NSString *)hw_contentTypeForImageData:(NSData *)data;

@end
