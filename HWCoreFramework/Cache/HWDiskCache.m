
#import "HWDiskCache.h"
#import <CommonCrypto/CommonCrypto.h>
#import "HWUtils.h"


#define LOCK() dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER)
#define UNLOCK() dispatch_semaphore_signal(self->_lock)

#define HW_DISK_CACHE_ERROR(error) \
if (error) { \
    NSLog(@"%@ (%d) ERROR: %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [error localizedDescription]); \
} \


/// Weak reference for all instances
static NSMapTable *_globalInstances;
/// Keep disk cache to be unique.
static dispatch_semaphore_t _globalInstancesLock;

static void _HWDiskCacheInitGlobal() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _globalInstancesLock = dispatch_semaphore_create(1);
        _globalInstances = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
    });
}

static HWDiskCache *_HWDiskCacheGetGlobal(NSString *path) {
    if (path.length == 0) return nil;
    _HWDiskCacheInitGlobal();
    dispatch_semaphore_wait(_globalInstancesLock, DISPATCH_TIME_FOREVER);
    id cache = [_globalInstances objectForKey:path];
    dispatch_semaphore_signal(_globalInstancesLock);
    return cache;
}

static void _HWDiskCacheSetGlobal(HWDiskCache *cache) {
    if (cache.path.length == 0) return;
    _HWDiskCacheInitGlobal();
    dispatch_semaphore_wait(_globalInstancesLock, DISPATCH_TIME_FOREVER);
    [_globalInstances setObject:cache forKey:cache.path];
    dispatch_semaphore_signal(_globalInstancesLock);
}


@implementation HWDiskCache {
    dispatch_semaphore_t _lock;
    dispatch_queue_t _queue;
}

- (void)dealloc {}

- (instancetype)initWithPath:(NSString *)path {
    self = [super init];
    if (self) {
        HWDiskCache *globalCache = _HWDiskCacheGetGlobal(path);
        if (globalCache) return globalCache;
        
        _path = path;
        _lock = dispatch_semaphore_create(1);
        _queue = dispatch_queue_create("com.parallelworld.cache.disk", DISPATCH_QUEUE_CONCURRENT);
        [self p_createCacheDirectory];
        _HWDiskCacheSetGlobal(self);

    }
    return self;
}

#pragma mark - Public

- (id<NSCoding>)objectForKey:(NSString *)key {
    if (!key) return nil;
    
    LOCK();
    NSString *filePath = [self p_encodedFilePathForKey:key];
    id<NSCoding> object = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        @try {
            object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        } @catch (NSException *exception) {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            HW_DISK_CACHE_ERROR(error);
        }
    }
    UNLOCK();
    
    return object;
}

- (void)objectForKey:(NSString *)key withBlock:(void (^)(NSString *, id<NSCoding>))block {
    if (!block) return;
    HW_WEAKIFY(self);
    dispatch_async(_queue, ^{
        HW_STRONGIFY(self);
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
    NSString *filePath = [self p_encodedFilePathForKey:key];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSError *writeError = nil;
    
    BOOL written = [data writeToFile:filePath options:NSDataWritingAtomic error:&writeError];
    HW_DISK_CACHE_ERROR(writeError);
    
    if (written) {
        [self p_setFileModificationDate:[NSDate date] forPath:filePath];
    }
    UNLOCK();
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void (^)(void))block {
    if (!block) return;
    HW_WEAKIFY(self);
    dispatch_async(_queue, ^{
        HW_STRONGIFY(self);
        [self setObject:object forKey:key];
        block();
    });
}

- (void)removeObjectForKey:(NSString *)key {
    if (!key) return;
    
    LOCK();
    NSString *filePath = [self p_encodedFilePathForKey:key];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
    }
    UNLOCK();
}

- (void)removeObjectForKey:(NSString *)key withBlock:(void (^)(NSString *))block {
    if (!block) return;
    HW_WEAKIFY(self);
    dispatch_async(_queue, ^{
        HW_STRONGIFY(self);
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
    HW_WEAKIFY(self);
    dispatch_async(_queue, ^{
        HW_STRONGIFY(self);
        [self removeAllObjects];
        block();
    });
}

#pragma mark - Private

- (NSString *)p_encodedFilePathForKey:(NSString *)key {
    if (key.length == 0) return nil;
    return [_path stringByAppendingPathComponent:[self p_encodedString:key]];
}

- (void)p_createCacheDirectory {
    if ([[NSFileManager defaultManager] fileExistsAtPath:_path]) return;
    [[NSFileManager defaultManager] createDirectoryAtPath:_path withIntermediateDirectories:YES attributes:nil error:NULL];
}

- (BOOL)p_setFileModificationDate:(NSDate *)date forPath:(NSString *)path {
    if (!date || !path) return NO;
    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] setAttributes:@{NSFileModificationDate: date} ofItemAtPath:path error:&error];
    HW_DISK_CACHE_ERROR(error);
    if (success) {
        
    }
    return success;
}

- (NSString *)p_encodedString:(NSString *)string {
    if (string.length == 0) return @"";
    return [string stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@".:/%"] invertedSet]];
}

- (NSString *)p_decodedString:(NSString *)string {
    if (string.length == 0) return @"";
    return [string stringByRemovingPercentEncoding];
}

@end
