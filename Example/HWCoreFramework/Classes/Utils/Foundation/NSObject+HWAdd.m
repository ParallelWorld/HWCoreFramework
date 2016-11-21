//
//  NSObject+HWAdd.m
//  HWCoreFramework
//
//  Created by 58 on 7/4/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "NSObject+HWAdd.h"
#import <objc/runtime.h>

@implementation NSObject (HWAdd)

- (void)hw_decode:(NSCoder *)decoder {
    [[self _hw_propertyNames] enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
        id value = [decoder decodeObjectForKey:name];
        if (!value) {
            return;
        }
        [self setValue:value forKey:name];
    }];

}

- (void)hw_encode:(NSCoder *)encoder {
    [[self _hw_propertyNames] enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
        id value = [self valueForKey:name];
        if (!value) {
            return;
        }
        [encoder encodeObject:value forKey:name];
    }];
}

- (NSArray<NSString *> *)_hw_propertyNames {
    NSMutableArray *arr = [NSMutableArray new];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    if (properties) {
        for (unsigned int i = 0; i < propertyCount; i++) {
            const char *name = property_getName(properties[i]);
            if (name) {
                [arr addObject:[NSString stringWithUTF8String:name]];
            }
        }
        free(properties);
    }
    return arr;
}

- (NSString *)hw_toString {
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    } else if ([self isKindOfClass:[NSNumber class]]){
        return [(NSNumber *)self stringValue];
    }
    return self.description;
}

@end
