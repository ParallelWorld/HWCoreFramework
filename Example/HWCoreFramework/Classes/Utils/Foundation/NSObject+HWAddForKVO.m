//
//  NSObject+HWAddForKVO.m
//  HWCoreFramework
//
//  Created by 58 on 7/4/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "NSObject+HWAddForKVO.h"
#import <objc/runtime.h>


@interface _HWNSObjectKVOBlockTarget : NSObject
@property (nonatomic, copy) void (^block)(id obj, id oldValue, id newValue);
- (instancetype)initWithBlock:(void (^)(id obj, id oldValue, id newValue))block;
@end

@implementation _HWNSObjectKVOBlockTarget

- (instancetype)initWithBlock:(void (^)(id, id, id))block {
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (!self.block) {
        return;
    }
    
    BOOL isPrior = [change[NSKeyValueChangeNotificationIsPriorKey] boolValue];
    if (isPrior) {
        return;
    }
    
    NSKeyValueChange changeKind = [change[NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) {
        return;
    }
    
    id oldValue = change[NSKeyValueChangeOldKey];
    if (oldValue == [NSNull null]) {
        oldValue = nil;
    }
    
    id newValue = change[NSKeyValueChangeNewKey];
    if (newValue == [NSNull null]) {
        newValue = nil;
    }
    
    self.block(object, oldValue, newValue);
}

@end

@implementation NSObject (HWAddForKVO)

- (void)hw_addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(id, id, id))block {
    if (!keyPath || !block) {
        return;
    }
    _HWNSObjectKVOBlockTarget *target = [[_HWNSObjectKVOBlockTarget alloc] initWithBlock:block];
    NSMutableDictionary *dic = [self _hw_allNSObjectObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    if (!arr) {
        arr = [NSMutableArray new];
        dic[keyPath] = arr;
    }
    [arr addObject:target];
    [self addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)hw_removeObserverBlocksForKeyPath:(NSString *)keyPath {
    if (!keyPath) {
        return;
    }
    NSMutableDictionary *dic = [self _hw_allNSObjectObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    [arr enumerateObjectsUsingBlock:^(id target, NSUInteger idx, BOOL *stop) {
        [self removeObserver:target forKeyPath:keyPath];
    }];
    [dic removeObjectForKey:keyPath];
}

- (void)hw_removeObserverBlocks {
    NSMutableDictionary *dic = [self _hw_allNSObjectObserverBlocks];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString *keyPath, NSArray *arr, BOOL *stop) {
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self removeObserver:obj forKeyPath:keyPath];
        }];
    }];
    [dic removeAllObjects];
}

- (NSMutableDictionary *)_hw_allNSObjectObserverBlocks {
    NSMutableDictionary *targets = objc_getAssociatedObject(self, _cmd);
    if (!targets) {
        targets = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
