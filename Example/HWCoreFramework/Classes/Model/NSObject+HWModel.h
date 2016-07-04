//
//  NSObject+HWModel.h
//  HWCoreFramework
//
//  Created by 58 on 6/23/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol HWModel <NSObject>
@optional

/// key是属性名，value是从字典中取值用的key
+ (nullable NSDictionary<NSString *, id> *)hw_modelCustomPropertyMapper;

/// key是数组属性名，value是数组中存放模型的Class（Class类型或NSString类型）
+ (nullable NSDictionary<NSString *, id> *)hw_modelContainerPropertyGenericClass;

/// 不进行转换
+ (nullable NSArray<NSString *> *)hw_modelPropertyBlacklist;

/// 进行转换
+ (nullable NSArray<NSString *> *)hw_modelPropertyWhitelist;

@end


@interface NSObject (HWModel) <HWModel>

/// json can be `NSDictionary`, `NSString` or `NSData`
///
/// Thread-safe
+ (nullable instancetype)hw_modelWithJSON:(id)json;

/// Dictionary->Model
///
/// Thread-safe
+ (nullable instancetype)hw_modelWithDictionary:(NSDictionary *)dictionary;

@end


@interface NSArray (HWModel)
+ (nullable NSArray *)hw_modelArrayWithClass:(Class)cls json:(id)json;
@end


@interface NSObject (HWCoding)
- (void)hw_decode:(NSCoder *)decoder;
- (void)hw_encode:(NSCoder *)encoder;
@end


#define HW_CODING_IMPLEMENTATION \
- (instancetype)initWithCoder:(NSCoder *)aDecoder { \
self = [super init]; \
if (self) { \
    [self hw_decode:aDecoder]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)aCoder { \
    [self hw_encode:aCoder]; \
} \


NS_ASSUME_NONNULL_END
