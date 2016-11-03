
#import <Foundation/Foundation.h>

@interface NSArray (HWAdd)

- (id)hw_objectOrNilAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (HWAdd)

- (void)hw_insertObject:(id)anObject atIndex:(NSUInteger)index;

- (void)hw_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

- (void)hw_reverse;

#pragma mark - Stack & Queue

- (void)hw_push:(id)anObject, ... NS_REQUIRES_NIL_TERMINATION;

- (id)hw_pop;

- (id)hw_shift;

- (void)hw_unshift:(id)anObject, ... NS_REQUIRES_NIL_TERMINATION;

@end
