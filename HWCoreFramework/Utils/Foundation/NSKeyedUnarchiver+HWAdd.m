//
//  NSKeyedUnarchiver+HWAdd.m
//  HWCoreFramework
//
//  Created by 58 on 6/23/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "NSKeyedUnarchiver+HWAdd.h"

@implementation NSKeyedUnarchiver (HWAdd)

+ (id)hw_unarchiveObjectWithData:(NSData *)data exception:(NSException **)exception {
    id object = nil;
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } @catch (NSException *e) {
        if (exception) *exception = e;
    } @finally {
        
    }
    return object;
}

+ (id)hw_unarchiveObjectWithFile:(NSString *)path exception:(NSException **)exception {
    id object = nil;
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    } @catch (NSException *e) {
        if (exception) *exception = e;
    } @finally {
        
    }
    return object;
}

@end
