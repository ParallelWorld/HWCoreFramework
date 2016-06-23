//
//  NSArray+HWAdd.h
//  Pods
//
//  Created by 58 on 6/13/16.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (HWAdd)

- (id)hw_objectOrNilAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (HWAdd)

- (void)hw_insertObject:(id)anObject atIndex:(NSUInteger)index;

- (void)hw_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

- (void)hw_reverse;

@end
