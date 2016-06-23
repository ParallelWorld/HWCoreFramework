//
//  HWTableSection.h
//  HWCoreFramework
//
//  Created by 58 on 6/16/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HWCellModel;

@interface HWTableSection : NSObject

- (NSInteger)numberOfCellModelsInSection;
- (HWCellModel *)cellModelAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfCellModel:(HWCellModel *)aCellModel;

- (void)addCellModel:(HWCellModel *)aCellModel;
- (void)insertCellModel:(HWCellModel *)aCellModel atIndex:(NSUInteger)index;
- (void)removeLastCellModel;
- (void)removeCellModelAtIndex:(NSUInteger)index;
- (void)replaceCellModelAtIndex:(NSUInteger)index withCellModel:(HWCellModel *)aCellModel;
- (void)exchangeCellModelAtIndex:(NSUInteger)idx1 withCellModelAtIndex:(NSUInteger)idx2;
- (void)removeAllCellModels;
- (void)removeCellModel:(HWCellModel *)aCellModel;

@end
