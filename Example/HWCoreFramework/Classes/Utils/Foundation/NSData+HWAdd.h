//
//  NSData+HWAdd.h
//  HWCoreFramework
//
//  Created by 58 on 6/23/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

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

@end
