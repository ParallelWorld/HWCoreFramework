
#import "NSArray+HWAdd.h"

@implementation NSArray (HWAdd)

- (id)hw_objectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
}

@end


@implementation NSMutableArray (HWAdd)

- (void)hw_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index >= self.count || !anObject) return;
    [self insertObject:anObject atIndex:index];
}

- (void)hw_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self hw_insertObject:obj atIndex:i++];
    }
}

- (void)hw_reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)hw_push:(id)anObject {
    if (!anObject) return;
    [self addObject:anObject];
}

- (id)hw_pop {
    id lastObject = [self lastObject];
    [self removeLastObject];
    return lastObject;
}

@end
