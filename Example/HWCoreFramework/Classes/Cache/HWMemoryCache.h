//
//  HWMemoryCache.h
//  HWCoreFramework
//
//  Created by ParallelWorld on 7/25/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// HWMemoryCache is a simple memory cache that stores key-value pairs.
/// In contrast to NSDictionary, keys are retained and not copied.
/// All methods are simple and thread-safe.
@interface HWMemoryCache : NSObject

/// If `YES`, the cache will remove all objects when the app receives a memory warning.
/// The default value is `YES`.
@property BOOL shouldRemoveAllObjectsOnMemoryWarning;

/// If `YES`, the cache will remove all objects when the app enter background.
/// The default value is `YES`.
@property BOOL shouldRemoveAllObjectsWhenEnteringBackground;

/// A block to be executed when the app receive a memory warning.
/// The default value is nil.
@property (nullable, copy) void(^didReceiveMemoryWarningBlock)(HWMemoryCache *cache);

/// A block to be executed when the app enter background.
/// The default value is nil.
@property (nullable, copy) void(^didEnterBackgroundBlock)(HWMemoryCache *cache);

/// If `YES`, the key-value pair will be released on main thread, otherwise on background thread. Default is NO.
/// You may set this value to `YES`, if the key-value contains the instance which should be released on main thread, such as UIView/CALayer.
@property BOOL releaseOnMainThread;

#pragma mark - Access methods

/// Returns the value associated with a given key.
/// @param key An object identifying the value. If nil, just return nil.
/// @return The value associated the key, or nil if no value is associated with key.
- (nullable id)objectForKey:(id)key;

/// Sets the value of the specified key int the cache.
/// Unlike an NSMutableDictionary object, a cache does not copy the key objects that are put into it.
/// @param object The object to be stored in the cache. If nil, it calls `removeObjectForKey:`.
/// @param key    The key with which to associated the value. If nil, this method has no effect.
- (void)setObject:(nullable id)object forKey:(id)key;

/// Removes the value of the specified key in the cache.
/// @param key The key identifying the value to be removed. If nil, this method has no effect.
- (void)removeObjectForKey:(id)key;

/// Empties the cache immediately.
- (void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
