//
//  HWDiskCache.m
//  HWCoreFramework
//
//  Created by 58 on 7/25/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "HWDiskCache.h"

#define LOCK() dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER)
#define UNLOCK() dispatch_semaphore_signal(self->_lock)

@implementation HWDiskCache {
    dispatch_semaphore_t _lock;
    dispatch_queue_t _queue;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
}

- (instancetype)initWithPath:(NSString *)path {
    self = [super init];
    if (self) {
        _path = path;
        _lock = dispatch_semaphore_create(1);
        _queue = dispatch_queue_create("com.parallelworld.cache.disk", DISPATCH_QUEUE_CONCURRENT);
        [self p_createCacheDirectory];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_appWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

#pragma mark - Public

- (id<NSCoding>)objectForKey:(NSString *)key {
    if (!key) return nil;
    
    LOCK();
    NSString *filePath = [self p_encodedFileURLForKey:key];
    id<NSCoding> object = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        @try {
            object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        } @catch (NSException *exception) {
            // TODO
        }
    }
    UNLOCK();
    
    return object;
}

- (void)objectForKey:(NSString *)key withBlock:(void (^)(NSString *, id<NSCoding>))block {
    if (!block) return;
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        id<NSCoding> object = [self objectForKey:key];
        block(key, object);
    });
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    if (!key) return;
    if (!object) {
        [self removeObjectForKey:key];
        return;
    }
    
    LOCK();
    NSString *filePath = [self p_encodedFileURLForKey:key];
    [NSKeyedArchiver archiveRootObject:object toFile:filePath];
    UNLOCK();
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void (^)(void))block {
    if (!block) return;
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        [self setObject:object forKey:key];
        block();
    });
}

- (void)removeObjectForKey:(NSString *)key {
    if (!key) return;
    
    LOCK();
    NSString *filePath = [self p_encodedFileURLForKey:key];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
    }
    UNLOCK();
}

- (void)removeObjectForKey:(NSString *)key withBlock:(void (^)(NSString *))block {
    if (!block) return;
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        [self removeObjectForKey:key];
        block(key);
    });
}

- (void)removeAllObjects {
    LOCK();
    [self p_createCacheDirectory];
    UNLOCK();
}

- (void)removeAllObjectsWithBlock:(void (^)(void))block {
    if (!block) return;
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        [self removeAllObjects];
        block();
    });
}

#pragma mark - Private

- (void)p_appWillTerminate {
    
}

- (NSString *)p_encodedFileURLForKey:(NSString *)key {
    if (key.length == 0) return nil;
    return [_path stringByAppendingPathComponent:key];
}

- (void)p_createCacheDirectory {
    if ([[NSFileManager defaultManager] fileExistsAtPath:_path]) return;
    [[NSFileManager defaultManager] createDirectoryAtPath:_path withIntermediateDirectories:YES attributes:nil error:NULL];
}

@end
