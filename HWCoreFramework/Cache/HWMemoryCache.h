
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWMemoryCache : NSObject

@property BOOL shouldRemoveAllObjectsOnMemoryWarning;

- (nullable id)objectForKey:(id)key;

- (void)setObject:(nullable id)object forKey:(id)key;

- (void)removeObjectForKey:(id)key;

- (void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
