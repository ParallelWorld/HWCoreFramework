
#import "HWTableSection.h"
#import "HWTableCellModel.h"

@interface HWTableSection ()

@property (nonatomic, strong) NSMutableArray<HWTableCellModel *> *models;

@end

@implementation HWTableSection

- (NSInteger)numberOfCellModelsInSection {
    return self.models.count;
}

- (HWTableCellModel *)cellModelAtIndex:(NSUInteger)index {
    return self.models[index];
}

- (NSUInteger)indexOfCellModel:(HWTableCellModel *)aCellModel {
    return [self.models indexOfObject:aCellModel];
}

- (void)addCellModel:(HWTableCellModel *)aCellModel {
    [self.models addObject:aCellModel];
}

- (void)insertCellModel:(HWTableCellModel *)aCellModel atIndex:(NSUInteger)index {
    [self.models insertObject:aCellModel atIndex:index];
}

- (void)removeLastCellModel {
    [self.models removeLastObject];
}

- (void)removeCellModelAtIndex:(NSUInteger)index {
    [self.models removeObjectAtIndex:index];
}

- (void)replaceCellModelAtIndex:(NSUInteger)index withCellModel:(HWTableCellModel *)aCellModel {
    [self.models replaceObjectAtIndex:index withObject:aCellModel];
}

- (void)exchangeCellModelAtIndex:(NSUInteger)idx1 withCellModelAtIndex:(NSUInteger)idx2 {
    [self.models exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (void)removeAllCellModels {
    [self.models removeAllObjects];
}

- (void)removeCellModel:(HWTableCellModel *)aCellModel {
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
