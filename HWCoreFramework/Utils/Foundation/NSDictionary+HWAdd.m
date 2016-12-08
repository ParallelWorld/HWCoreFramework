//
//  NSDictionary+HWAdd.m
//  HWCoreFramework
//
//  Created by 58 on 6/23/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "NSDictionary+HWAdd.h"

@implementation NSDictionary (HWAdd)

/// Get a number value from 'id'.
static NSNumber *NSNumberFromID(id value) {
    static NSCharacterSet *dot;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dot = [NSCharacterSet characterSetWithRange:NSMakeRange('.', 1)];
    });
    if (!value || value == [NSNull null]) return nil;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) {
        NSString *lower = ((NSString *)value).lowercaseString;
        if ([lower isEqualToString:@"true"] || [lower isEqualToString:@"yes"]) return @(YES);
        if ([lower isEqualToString:@"false"] || [lower isEqualToString:@"no"]) return @(NO);
        if ([lower isEqualToString:@"nil"] || [lower isEqualToString:@"null"]) return nil;
        if ([(NSString *)value rangeOfCharacterFromSet:dot].location != NSNotFound) {
            return @(((NSString *)value).doubleValue);
        } else {
            return @(((NSString *)value).longLongValue);
        }
    }
    return nil;
}

#define HW_RETURN_VALUE(_type_)                                                  \
if (!key) return def;                                                            \
id value = self[key];                                                            \
if (!value || value == [NSNull null]) return def;                                \
if ([value isKindOfClass:[NSNumber class]]) return ((NSNumber *)value)._type_;   \
if ([value isKindOfClass:[NSString class]]) return NSNumberFromID(value)._type_; \
return def;

- (BOOL)hw_boolValueForKey:(NSString *)key default:(BOOL)def {
    HW_RETURN_VALUE(boolValue);
}

- (char)hw_charValueForKey:(NSString *)key default:(char)def {
    HW_RETURN_VALUE(charValue);
}

- (unsigned char)hw_unsignedCharValueForKey:(NSString *)key default:(unsigned char)def {
    HW_RETURN_VALUE(unsignedCharValue);
}

- (short)hw_shortValueForKey:(NSString *)key default:(short)def {
    HW_RETURN_VALUE(shortValue);
}

- (unsigned short)hw_unsignedShortValueForKey:(NSString *)key default:(unsigned short)def {
    HW_RETURN_VALUE(unsignedShortValue);
}

- (int)hw_intValueForKey:(NSString *)key default:(int)def {
    HW_RETURN_VALUE(intValue);
}

- (unsigned int)hw_unsignedIntValueForKey:(NSString *)key default:(unsigned int)def {
    HW_RETURN_VALUE(unsignedIntValue);
}

- (long)hw_longValueForKey:(NSString *)key default:(long)def {
    HW_RETURN_VALUE(longValue);
}

- (unsigned long)hw_unsignedLongValueForKey:(NSString *)key default:(unsigned long)def {
    HW_RETURN_VALUE(unsignedLongValue);
}

- (long long)hw_longLongValueForKey:(NSString *)key default:(long long)def {
    HW_RETURN_VALUE(longLongValue);
}

- (unsigned long long)hw_unsignedLongLongValueForKey:(NSString *)key default:(unsigned long long)def {
    HW_RETURN_VALUE(unsignedLongLongValue);
}

- (float)hw_floatValueForKey:(NSString *)key default:(float)def {
    HW_RETURN_VALUE(floatValue);
}

- (double)hw_doubleValueForKey:(NSString *)key default:(double)def {
    HW_RETURN_VALUE(doubleValue);
}

- (NSInteger)hw_integerValueForKey:(NSString *)key default:(NSInteger)def {
    HW_RETURN_VALUE(integerValue);
}

- (NSUInteger)hw_unsignedIntegerValueForKey:(NSString *)key default:(NSUInteger)def {
    HW_RETURN_VALUE(unsignedIntegerValue);
}

- (NSNumber *)hw_numberValueForKey:(NSString *)key default:(NSNumber *)def {
    if (!key) return def;
    id value = self[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) return NSNumberFromID(value);
    return def;
}

- (NSString *)hw_stringValueForKey:(NSString *)key default:(NSString *)def {
    if (!key) return def;
    id value = self[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSString class]]) return value;
    if ([value isKindOfClass:[NSNumber class]]) return ((NSNumber *)value).description;
    return def;
}

@end


@implementation NSMutableDictionary (HWAdd)

- (id)hw_removeObjectForKey:(id)aKey {
    if (!aKey) return nil;
    id value = self[aKey];
    [self removeObjectForKey:aKey];
    return value;
}

- (void)hw_setObject:(id)anObject forKey:(id)aKey {
    if (!aKey) return;
    if (!anObject) return;
    [self setObject:anObject forKey:aKey];
}

@end

