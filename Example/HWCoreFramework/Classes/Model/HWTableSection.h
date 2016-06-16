//
//  HWTableSection.h
//  HWCoreFramework
//
//  Created by 58 on 6/16/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HWBaseCellModel;

@interface HWTableSection : NSObject

- (NSInteger)numberOfCellModelsInSection;
- (HWBaseCellModel *)cellModelAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfCellModel:(HWBaseCellModel *)aCellModel;

- (void)addCellModel:(HWBaseCellModel *)aCellModel;
- (void)insertCellModel:(HWBaseCellModel *)aCellModel atIndex:(NSUInteger)index;
- (void)removeLastCellModel;
- (void)removeCellModelAtIndex:(NSUInteger)index;
- (void)replaceCellModelAtIndex:(NSUInteger)index withCellModel:(HWBaseCellModel *)aCellModel;
- (void)exchangeCellModelAtIndex:(NSUInteger)idx1 withCellModelAtIndex:(NSUInteger)idx2;
- (void)removeAllCellModels;
- (void)removeCellModel:(HWBaseCellModel *)aCellModel;

@end
