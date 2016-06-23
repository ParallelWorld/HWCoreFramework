//
//  NSDictionary+HWAdd.h
//  HWCoreFramework
//
//  Created by 58 on 6/23/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HWAdd)

#pragma mark - Dictionary value getter

- (BOOL)hw_boolValueForKey:(NSString *)key default:(BOOL)def;

- (char)hw_charValueForKey:(NSString *)key default:(char)def;
- (unsigned char)hw_unsignedCharValueForKey:(NSString *)key default:(unsigned char)def;

- (short)hw_shortValueForKey:(NSString *)key default:(short)def;
- (unsigned short)hw_unsignedShortValueForKey:(NSString *)key default:(unsigned short)def;

- (int)hw_intValueForKey:(NSString *)key default:(int)def;
- (unsigned int)hw_unsignedIntValueForKey:(NSString *)key default:(unsigned int)def;

- (long)hw_longValueForKey:(NSString *)key default:(long)def;
- (unsigned long)hw_unsignedLongValueForKey:(NSString *)key default:(unsigned long)def;

- (long long)hw_longLongValueForKey:(NSString *)key default:(long long)def;
- (unsigned long long)hw_unsignedLongLongValueForKey:(NSString *)key default:(unsigned long long)def;

- (float)hw_floatValueForKey:(NSString *)key default:(float)def;
- (double)hw_doubleValueForKey:(NSString *)key default:(double)def;

- (NSInteger)hw_integerValueForKey:(NSString *)key default:(NSInteger)def;
- (NSUInteger)hw_unsignedIntegerValueForKey:(NSString *)key default:(NSUInteger)def;

- (NSNumber *)hw_numberValueForKey:(NSString *)key default:(NSNumber *)def;
- (NSString *)hw_stringValueForKey:(NSString *)key default:(NSString *)def;

@end

@interface NSMutableDictionary (HWAdd)

- (void)hw_setObject:(id)anObject forKey:(id)aKey;

- (id)hw_removeObjectForKey:(id)aKey;

@end
