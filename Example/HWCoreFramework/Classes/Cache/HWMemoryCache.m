//
//  HWMemoryCache.m
//  HWCoreFramework
//
//  Created by 58 on 7/25/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "HWMemoryCache.h"


@implementation HWMemoryCache {
    pthread_mutex_t _lock;
    CFMutableDictionaryRef _dic;
}

#pragma mark - Life cycle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    pthread_mutex_destroy(&_lock);
}

- (instancetype)init {
    self = [super init];
    pthread_mutex_init(&_lock, NULL);
    _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    _shouldRemoveAllObjectsOnMemoryWarning = YES;
    _shouldRemoveAllObjectsWhenEnteringBackground = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_appDidReceiveMemoryWarningNotification) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_appDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
    return self;
}

#pragma mark - Public

- (id)objectForKey:(id)key {
    if (!key) return nil;
    pthread_mutex_lock(&_lock);
    id object = CFDictionaryGetValue(_dic, (__bridge const void *)key);
    pthread_mutex_unlock(&_lock);
    return object;
}

- (void)setObject:(id)object forKey:(id)key {
    if (!key) return;
    if (!object) {
        [self removeObjectForKey:key];
        return;
    }
    pthread_mutex_lock(&_lock);
    CFDictionarySetValue(_dic, (__bridge const void *)key, (__bridge const void *)object);
    pthread_mutex_unlock(&_lock);
}

- (void)removeObjectForKey:(id)key {
    if (!key) return;
    pthread_mutex_lock(&_lock);
    CFDictionaryRemoveValue(_dic, (__bridge const void *)key);
    pthread_mutex_unlock(&_lock);
}

- (void)removeAllObjects {
    pthread_mutex_lock(&_lock);
    CFDictionaryRemoveAllValues(_dic);
    pthread_mutex_unlock(&_lock);
}

#pragma mark - Private

- (void)p_appDidReceiveMemoryWarningNotification {
    if (self.didReceiveMemoryWarningBlock) {
        self.didReceiveMemoryWarningBlock(self);
    }
    if (self.shouldRemoveAllObjectsOnMemoryWarning) {
        [self removeAllObjects];
    }
}

- (void)p_appDidEnterBackgroundNotification {
    if (self.didEnterBackgroundBlock) {
        self.didEnterBackgroundBlock(self);
    }
    if (self.shouldRemoveAllObjectsWhenEnteringBackground) {
        [self removeAllObjects];
    }
}

@end
