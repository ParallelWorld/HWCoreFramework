//
//  NSObject+HWModel.m
//  HWCoreFramework
//
//  Created by 58 on 6/23/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "NSObject+HWModel.h"
#import "HWClassInfo.h"
#import <Objc/runtime.h>


@implementation NSObject (HWModel)

+ (nullable instancetype)hw_modelWithJSON:(id)json {
    // JSON->Dictionary
    NSDictionary *dic = nil;
    if (!json) dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) {
            dic = nil;
        }
    }
    
    return [self hw_modelWithDictionary:dic];
}

+ (nullable instancetype)hw_modelWithDictionary:(NSDictionary *)dictionary {
    NSObject *model = [self new];
    
    HWClassInfo *classInfo = [HWClassInfo classInfoWithClass:self];
    
    NSArray *allowedPropertyNames = ({
        NSArray *array = nil;
        if ([self respondsToSelector:@selector(hw_modelPropertyWhitelist)]) {
            array = [self hw_modelPropertyWhitelist];
        }
        array;
    });
    
    NSArray *ignoredPropertyNames = ({
        NSArray *array = nil;
        if ([self respondsToSelector:@selector(hw_modelPropertyBlacklist)]) {
            array = [self hw_modelPropertyBlacklist];
        }
        array;
    });
    
    [classInfo.propertyInfos enumerateKeysAndObjectsUsingBlock:^(NSString *key, HWClassPropertyInfo *property, BOOL *stop) {
        // 获取`hw_objectClassInArray`中的class
        Class objectClassInArray = nil;
        if ([self respondsToSelector:@selector(hw_modelContainerPropertyGenericClass)]) {
            NSDictionary *dic = [self hw_modelContainerPropertyGenericClass];
            id value = dic[property.name];
            if (value) {
                if ([value isKindOfClass:[NSString class]]) {
                    objectClassInArray = NSClassFromString(value);
                } else {
                    objectClassInArray = value;
                }
            }
        }
        
        // 获取`hw_replacedKeyFromPropertyName`中的key
        NSString *keyInDictionary = key;
        if ([self respondsToSelector:@selector(hw_modelCustomPropertyMapper)]) {
            NSDictionary *replacedKey = [self hw_modelCustomPropertyMapper];
            keyInDictionary = replacedKey[key] ?: key;
        }
        
        // 检查是否被忽略
        if (allowedPropertyNames.count > 0 && ![allowedPropertyNames containsObject:property.name]) return;
        if ([ignoredPropertyNames containsObject:property.name]) return;
        
        // 取出属性值
        id value;
        value = dictionary[keyInDictionary];
        
        // 没有值，直接返回
        if (!value || value == [NSNull null]) return;
        if (property.cls && !property.fromFoundation) { // 自定义类
            value = [property.cls hw_modelWithDictionary:value];
        } else if ([value isKindOfClass:[NSArray class]]) { // 数组中的类类型
            value = [NSArray hw_modelArrayWithClass:objectClassInArray json:value];
        } else { // 特定类型的相互转化
            if (property.cls == [NSString class] && [value isKindOfClass:[NSNumber class]]) {
                // NSNumber->NSString
                value = [value description];
            } else if (property.cls == [NSNumber class] && [value isKindOfClass:[NSString class]]) {
                // NSString->NSNumber
                value = [[NSNumberFormatter new] numberFromString:value];
            }
            if (property.cls && ![value isKindOfClass:property.cls]) {
                value = nil;
            }
        }
        
        // 赋值
        if (value) {
            [model setValue:value forKey:key];
        }
    }];
    
    return model;
}
        

@end

@implementation NSObject (HWCoding)

- (void)hw_decode:(NSCoder *)decoder {
    HWClassInfo *classInfo = [HWClassInfo classInfoWithClass:[self class]];
    [classInfo.propertyInfos enumerateKeysAndObjectsUsingBlock:^(NSString *key, HWClassPropertyInfo *obj, BOOL *stop) {
        id value = [decoder decodeObjectForKey:obj.name];
        if (!value) {
            return;
        }
        [self setValue:value forKey:obj.name];
    }];
}

- (void)hw_encode:(NSCoder *)encoder {
    HWClassInfo *classInfo = [HWClassInfo classInfoWithClass:[self class]];
    [classInfo.propertyInfos enumerateKeysAndObjectsUsingBlock:^(NSString *key, HWClassPropertyInfo *obj, BOOL *stop) {
        id value = [self valueForKey:obj.name];
        if (!value) {
            return;
        }
        [encoder encodeObject:value forKey:obj.name];
    }];
}

@end


@implementation NSArray (HWModel)

+ (NSArray *)hw_modelArrayWithClass:(Class)cls json:(id)json {
    if (!json) return nil;
    NSArray *arr = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSArray class]]) {
        arr = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    
    if (jsonData) {
        arr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![arr isKindOfClass:[NSArray class]]) {
            arr = nil;
        }
    }
    return [self hw_modelArrayWithClass:cls array:arr];
}

+ (NSArray *)hw_modelArrayWithClass:(Class)cls array:(NSArray *)arr {
    if (!cls || !arr) {
        return nil;
    }
    NSMutableArray *result = [NSMutableArray new];
    for (NSDictionary *dic in arr) {
        if (![dic isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        NSObject *obj = [cls hw_modelWithDictionary:dic];
        if (obj) {
            [result addObject:obj];
        }
    }
    return result;
}

@end

