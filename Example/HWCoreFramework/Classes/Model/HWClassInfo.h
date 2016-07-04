//
//  HWClassInfo.h
//  HWCoreFramework
//
//  Created by 58 on 6/28/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, HWEncodingType) {
    HWEncodingTypeMask       = 0xFF,///< mask of type value
    HWEncodingTypeUnknown    = 0,///< unknown
    HWEncodingTypeVoid       = 1,///< void
    HWEncodingTypeBool       = 2,///< bool
    HWEncodingTypeInt8       = 3,///< char / BOOL
    HWEncodingTypeUInt8      = 4,///< unsigned char
    HWEncodingTypeInt16      = 5,///< short
    HWEncodingTypeUInt16     = 6,///< unsigned short
    HWEncodingTypeInt32      = 7,///< int
    HWEncodingTypeUInt32     = 8,///< unsigned int
    HWEncodingTypeInt64      = 9,///< long long
    HWEncodingTypeUInt64     = 10,///< unsigned long long
    HWEncodingTypeFloat      = 11,///< float
    HWEncodingTypeDouble     = 12,///< double
    HWEncodingTypeLongDouble = 13,///< long double
    HWEncodingTypeObject     = 14,///< id
    HWEncodingTypeClass      = 15,///< Class
    HWEncodingTypeSEL        = 16,///< SEL
    HWEncodingTypeBlock      = 17,///< block
    HWEncodingTypePointer    = 18,///< void*
    HWEncodingTypeStruct     = 19,///< struct
    HWEncodingTypeUnion      = 20,///< union
    HWEncodingTypeCString    = 21,///< char*
    HWEncodingTypeCArray     = 22,///< char[10] (for example)
    
    HWEncodingTypeQualifierMask   = 0xFF00,///< mask of qualifier
    HWEncodingTypeQualifierConst  = 1 << 8,///< const
    HWEncodingTypeQualifierIn     = 1 << 9,///< in
    HWEncodingTypeQualifierInout  = 1 << 10,///< inout
    HWEncodingTypeQualifierOut    = 1 << 11,///< out
    HWEncodingTypeQualifierBycopy = 1 << 12,///< bycopy
    HWEncodingTypeQualifierByref  = 1 << 13,///< byref
    HWEncodingTypeQualifierOneway = 1 << 14,///< oneway
    
    HWEncodingTypePropertyMask         = 0xFF0000,///< mask of property
    HWEncodingTypePropertyReadonly     = 1 << 16,///< readonly
    HWEncodingTypePropertyCopy         = 1 << 17,///< copy
    HWEncodingTypePropertyRetain       = 1 << 18,///< retain
    HWEncodingTypePropertyNonatomic    = 1 << 19,///< nonatomic
    HWEncodingTypePropertyWeak         = 1 << 20,///< weak
    HWEncodingTypePropertyCustomGetter = 1 << 21,///< getter=
    HWEncodingTypePropertyCustomSetter = 1 << 22,///< setter=
    HWEncodingTypePropertyDynamic      = 1 << 23,///< @dynamic
};

/// https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
/// https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
HWEncodingType HWEncodingGetType(const char *typeEncoding);


@interface HWClassMethodInfo : NSObject
@property (nonatomic, assign, readonly) Method method;
@property (nonatomic, assign, readonly) SEL sel;
@property (nonatomic, assign, readonly) IMP imp;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *typeEncoding;
@property (nonatomic, strong, readonly) NSString *returnTypeEncoding;
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings;
- (instancetype)initWithMethod:(Method)method;
@end


@interface HWClassPropertyInfo : NSObject
@property (nonatomic, assign, readonly) objc_property_t property;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *typeEncoding;
@property (nonatomic, assign, readonly) BOOL fromFoundation; ///< 类型是否来自于Foundation框架，比如NSString、NSArray等
@property (nullable, nonatomic, assign, readonly) Class cls;
- (instancetype)initWithProperty:(objc_property_t)property;
@end


@interface HWClassInfo : NSObject
@property (nonatomic, assign, readonly) Class cls;
@property (nullable, nonatomic, assign, readonly) Class superCls;
@property (nullable, nonatomic, assign, readonly) Class metaCls;
@property (nonatomic, readonly) BOOL isMeta;
@property (nonatomic, strong, readonly) NSString *name;
@property (nullable, nonatomic, strong, readonly) HWClassInfo *superClsInfo;
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, HWClassMethodInfo *> *methodInfos;
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, HWClassPropertyInfo *> *propertyInfos;

+ (nullable instancetype)classInfoWithClass:(Class)cls;
+ (nullable instancetype)classInfoWithClassName:(NSString *)className;

- (void)setNeedsUpdate;
- (BOOL)needsUpdate;

@end

NS_ASSUME_NONNULL_END
