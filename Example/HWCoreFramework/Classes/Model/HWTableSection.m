//
//  HWTableSection.m
//  HWCoreFramework
//
//  Created by 58 on 6/16/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "HWTableSection.h"
#import "HWBaseCellModel.h"

@interface HWTableSection ()

@property (nonatomic, strong) NSMutableArray<HWBaseCellModel *> *models;

@end

@implementation HWTableSection

- (NSInteger)numberOfCellModelsInSection {
    return self.models.count;
}

- (HWBaseCellModel *)cellModelAtIndex:(NSUInteger)index {
    return self.models[index];
}

- (NSUInteger)indexOfCellModel:(HWBaseCellModel *)aCellModel {
    return [self.models indexOfObject:aCellModel];
}

- (void)addCellModel:(HWBaseCellModel *)aCellModel {
    [self.models addObject:aCellModel];
}

- (void)insertCellModel:(HWBaseCellModel *)aCellModel atIndex:(NSUInteger)index {
    [self.models insertObject:aCellModel atIndex:index];
}

- (void)removeLastCellModel {
    [self.models removeLastObject];
}

- (void)removeCellModelAtIndex:(NSUInteger)index {
    [self.models removeObjectAtIndex:index];
}

- (void)replaceCellModelAtIndex:(NSUInteger)index withCellModel:(HWBaseCellModel *)aCellModel {
    [self.models replaceObjectAtIndex:index withObject:aCellModel];
}

- (void)exchangeCellModelAtIndex:(NSUInteger)idx1 withCellModelAtIndex:(NSUInteger)idx2 {
    [self.models exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (void)removeAllCellModels {
    [self.models removeAllObjects];
}

- (void)removeCellModel:(HWBaseCellModel *)aCellModel {
    [self.models removeObject:aCellModel];
}

#pragma mark - Getters

- (NSMutableArray *)models {
    if (!_models) {
        _models = [NSMutableArray new];
    }
    return _models;
}

@end
