//
//  NSObject+HWAddForKVO.h
//  HWCoreFramework
//
//  Created by 58 on 7/4/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HWAddForKVO)

- (void)hw_addObserverBlockForKeyPath:(NSString *)keyPath
                                block:(void (^)(id obj, id oldValue, id newValue))block;

- (void)hw_removeObserverBlocksForKeyPath:(NSString *)keyPath;

- (void)hw_removeObserverBlocks;

@end
