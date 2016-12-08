//
//  HWClassInfo.m
//  HWCoreFramework
//
//  Created by 58 on 6/28/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "HWClassInfo.h"


HWEncodingType HWEncodingGetType(const char *typeEncoding) {
    char *type = (char *)typeEncoding;
    if (!type) return HWEncodingTypeUnknown;
    size_t len = strlen(type);
    if (len == 0) return HWEncodingTypeUnknown;
    
    HWEncodingType qualifier = 0;
    bool prefix = true;
    while (prefix) {
        switch (*type) {
            case 'r': {
                qualifier |= HWEncodingTypeQualifierConst;
                type++;
            } break;
            case 'n': {
                qualifier |= HWEncodingTypeQualifierIn;
                type++;
            } break;
            case 'N': {
                qualifier |= HWEncodingTypeQualifierInout;
                type++;
            } break;
            case 'o': {
                qualifier |= HWEncodingTypeQualifierOut;
                type++;
            } break;
            case 'O': {
                qualifier |= HWEncodingTypeQualifierBycopy;
                type++;
            } break;
            case 'R': {
                qualifier |= HWEncodingTypeQualifierByref;
                type++;
            } break;
            case 'V': {
                qualifier |= HWEncodingTypeQualifierOneway;
                type++;
            } break;
            default: {
                prefix = false;
            } break;
        }
    }
    
    len = strlen(type);
    if (len == 0) return HWEncodingTypeUnknown | qualifier;
    
    switch (*type) {
        case 'v': return HWEncodingTypeVoid | qualifier;
        case 'B': return HWEncodingTypeBool | qualifier;
        case 'c': return HWEncodingTypeInt8 | qualifier;
        case 'C': return HWEncodingTypeUInt8 | qualifier;
        case 's': return HWEncodingTypeInt16 | qualifier;
        case 'S': return HWEncodingTypeUInt16 | qualifier;
        case 'i': return HWEncodingTypeInt32 | qualifier;
        case 'I': return HWEncodingTypeUInt32 | qualifier;
        case 'l': return HWEncodingTypeInt32 | qualifier;
        case 'L': return HWEncodingTypeUInt32 | qualifier;
        case 'q': return HWEncodingTypeInt64 | qualifier;
        case 'Q': return HWEncodingTypeUInt64 | qualifier;
        case 'f': return HWEncodingTypeFloat | qualifier;
        case 'd': return HWEncodingTypeDouble | qualifier;
        case 'D': return HWEncodingTypeLongDouble | qualifier;
        case '#': return HWEncodingTypeClass | qualifier;
        case ':': return HWEncodingTypeSEL | qualifier;
        case '*': return HWEncodingTypeCString | qualifier;
        case '^': return HWEncodingTypePointer | qualifier;
        case '[': return HWEncodingTypeCArray | qualifier;
        case '(': return HWEncodingTypeUnion | qualifier;
        case '{': return HWEncodingTypeStruct | qualifier;
        case '@': {
            if (len == 2 && *(type+1) == '?') {
                return HWEncodingTypeBlock | qualifier;
            } else {
                return HWEncodingTypeObject | qualifier;
            }
        }
        default: return HWEncodingTypeUnknown | qualifier;
    }
    return qualifier;
}


@implementation HWClassMethodInfo

- (instancetype)initWithMethod:(Method)method {
    if (!method) return nil;
    self = [super init];
    _method = method;
    _sel = method_getName(method);
    _imp = method_getImplementation(method);
    const char *name = sel_getName(_sel);
    if (name) {
        _name = [NSString stringWithUTF8String:name];
    }
    const char *typeEncoding = method_getTypeEncoding(method);
    if (typeEncoding) {
        _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
    }
    char *returnType = method_copyReturnType(method);
    if (returnType) {
        _returnTypeEncoding = [NSString stringWithUTF8String:returnType];
        free(returnType);
    }
    unsigned int argumentCount = method_getNumberOfArguments(method);
    if (argumentCount > 0) {
        NSMutableArray *argumentTypes = [NSMutableArray new];
        for (unsigned int i = 0; i < argumentCount; i++) {
            char *argumentType = method_copyArgumentType(method, i);
            if (argumentType) {
                [argumentTypes addObject:[NSString stringWithUTF8String:argumentType]];
                free(argumentType);
            } else {
                [argumentTypes addObject:@""];
            }
        }
        _argumentTypeEncodings = argumentTypes;
    }
    return self;
}

@end


@implementation HWClassPropertyInfo

- (instancetype)initWithProperty:(objc_property_t)property {
    if (!property) return nil;
    self = [super init];
    _property = property;
    const char *name = property_getName(property);
    if (name) {
        _name = [NSString stringWithUTF8String:name];
    }
    
    HWEncodingType type = 0;
    unsigned int attrCount;
    objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
    for (unsigned int i = 0; i < attrCount; i++) {
        objc_property_attribute_t attr = attrs[i];
        switch (attr.name[0]) {
            case 'T': { // Type encoding
                if (attr.value) {
                    _typeEncoding = [NSString stringWithUTF8String:attr.value];
                    type = HWEncodingGetType(attr.value);
                    
                    if ((type & HWEncodingTypeMask) == HWEncodingTypeObject && _typeEncoding.length) {
                        NSScanner *scanner = [NSScanner scannerWithString:_typeEncoding];
                        if (![scanner scanString:@"@\"" intoString:NULL]) continue;
                        
                        NSString *clsName = nil;
                        if ([scanner scanUpToCharactersFromSet: [NSCharacterSet characterSetWithCharactersInString:@"\"<"] intoString:&clsName]) {
                            if (clsName.length) _cls = objc_getClass(clsName.UTF8String);
                        }
                    }
                }
                break;
            }
            default:
                break;
        }
    }
    if (attrs) {
        free(attrs);
        attrs = NULL;
    }
    
    
    __block BOOL isFromFoundation = NO;
    if (_cls == [NSObject class]) isFromFoundation = YES;
    [@[NSURL.class,
       NSDate.class,
       NSValue.class,
       NSData.class,
       NSError.class,
       NSArray.class,
       NSDictionary.class,
       NSString.class,
       NSAttributedString.class] enumerateObjectsUsingBlock:^(Class obj, NSUInteger idx, BOOL *stop) {
           if ([_cls isSubclassOfClass:obj]) {
               isFromFoundation = YES;
               *stop = YES;
           }
       }];
    _fromFoundation = isFromFoundation;

    return self;
}

@end

@implementation HWClassInfo {
    BOOL _needsUpdate;
}

- (instancetype)initWithClass:(Class)cls {
    if (!cls) return nil;
    self = [super init];
    _cls = cls;
    _superCls = class_getSuperclass(cls);
    _isMeta = class_isMetaClass(cls);
    if (!_isMeta) {
        _metaCls = objc_getMetaClass(class_getName(cls));
    }
    _name = NSStringFromClass(cls);
    [self _update];
    
    _superClsInfo = [self.class classInfoWithClass:_superCls];
    return self;
}

- (void)_update {
    _methodInfos = nil;
    _propertyInfos = nil;
    
    Class cls = self.cls;
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(cls, &methodCount);
    if (methods) {
        NSMutableDictionary *methodInfos = [NSMutableDictionary new];
        _methodInfos = methodInfos;
        for (unsigned int i = 0; i < methodCount; i++) {
            HWClassMethodInfo *info = [[HWClassMethodInfo alloc] initWithMethod:methods[i]];
            if (info.name) {
                methodInfos[info.name] = info;
            }
        }
        free(methods);
    }
    
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
    if (properties) {
        NSMutableDictionary *propertyInfos = [NSMutableDictionary new];
        _propertyInfos = propertyInfos;
        for (unsigned int i = 0; i < propertyCount; i++) {
            HWClassPropertyInfo *info = [[HWClassPropertyInfo alloc] initWithProperty:properties[i]];
            if (info.name) {
                propertyInfos[info.name] = info;
            }
        }
        free(properties);
    }
    
    if (!_methodInfos) _methodInfos = @{};
    if (!_propertyInfos) _propertyInfos = @{};
}

+ (instancetype)classInfoWithClass:(Class)cls {
    if (!cls) return nil;
    
    static NSMutableDictionary *classCache;
    static NSMutableDictionary *metaCache;
    static dispatch_semaphore_t lock;
    static dispatch_once_t onceToken;
    NSString *className = NSStringFromClass(cls);

    dispatch_once(&onceToken, ^{
        classCache = [NSMutableDictionary new];
        metaCache = [NSMutableDictionary new];
        lock = dispatch_semaphore_create(1);
    });
    
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    HWClassInfo *info = class_isMetaClass(cls) ? metaCache[className] : classCache[className];
    if (info && info->_needsUpdate) {
        [info _update];
    }
    dispatch_semaphore_signal(lock);
    
    if (!info) {
        info = [[HWClassInfo alloc] initWithClass:cls];
        if (info) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            info.isMeta ? (metaCache[className] = info) : (classCache[className] = info);
            dispatch_semaphore_signal(lock);
        }
    }
    return info;
}

+ (instancetype)classInfoWithClassName:(NSString *)className {
    Class cls = NSClassFromString(className);
    return [self classInfoWithClass:cls];
}

- (void)setNeedsUpdate {
    
}

- (BOOL)needsUpdate {
    return NO;
}

@end
