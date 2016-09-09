//
//  HWBaseTableSource.m
//  Pods
//
//  Created by 58 on 6/14/16.
//
//

#import "HWTableDataSource.h"
#import "HWUtils.h"
#import "HWTableSection.h"

@interface HWTableDataSource ()

@property (nonatomic, strong) NSMutableArray<HWTableSection *> *sectionModels;

@end

@implementation HWTableDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        _canLoadMore = YES;
        _sectionModels = [NSMutableArray new];
    }
    return self;
}

- (void)refreshSource {
    if ([self.delegate respondsToSelector:@selector(tableDataSourceDidStartRefresh:)]) {
        [self.delegate tableDataSourceDidStartRefresh:self];
    }
    
    if (!self.request) {
        hw_dispatch_async_on_global_queue(^{
            [self configureRefreshData:nil];
            hw_dispatch_async_on_main_queue(^{
                if ([self.delegate respondsToSelector:@selector(tableDataSourceDidFinishRefresh:)]) {
                    [self.delegate tableDataSourceDidFinishRefresh:self];
                }
            });
        });
    } else {
//        HW_WEAKIFY(self);
//        [self.request startWithSuccessHandler:^(HWNetworkResponse * _Nonnull response, id  _Nonnull data) {
//            HW_STRONGIFY(self);
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [self prepareData:data];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self _notifyDelegateDidEndRefresh];
//                });
//            });
//        } failureHandler:^(HWNetworkResponse * _Nonnull response, NSError * _Nonnull error) {
//            HW_STRONGIFY(self);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self _notifyDelegateDidEndRefreshWithError:error];
//            });
//        }];
    }
}

- (void)loadMoreSource {
    if ([self.delegate respondsToSelector:@selector(tableDataSourceDidStartLoadMore:)]) {
        [self.delegate tableDataSourceDidStartLoadMore:self];
    }
    
    if (!self.request) {
        hw_dispatch_async_on_global_queue(^{
            [self configureLoadMoreData:nil];
            hw_dispatch_async_on_main_queue(^{
                if ([self.delegate respondsToSelector:@selector(tableDataSourceDidFinishLoadMore:)]) {
                    [self.delegate tableDataSourceDidFinishLoadMore:self];
                }
            });
        });
    } else {
//        HW_WEAKIFY(self);
//        [self.request startWithSuccessHandler:^(HWNetworkResponse * _Nonnull response, id  _Nonnull data) {
//            HW_STRONGIFY(self);
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [self prepareData:data];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self _notifyDelegateDidEndLoadMore];
//                });
//            });
//        } failureHandler:^(HWNetworkResponse * _Nonnull response, NSError * _Nonnull error) {
//            HW_STRONGIFY(self);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self _notifyDelegateDidEndLoadMoreWithError:error];
//            });
//        }];
    }
}

- (void)configureRefreshData:(id)data {
    [self removeAllSections];
    self.canLoadMore = YES;
}

- (void)configureLoadMoreData:(id)data {
    
}

- (NSString *)identifierForCellClass:(Class)aClass {
    return [NSStringFromClass(aClass) stringByReplacingOccurrencesOfString:@"Cell" withString:@"CellModel"];
}

- (HWTableCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sectionModels[indexPath.section] cellModelAtIndex:indexPath.row];
}

- (NSInteger)numberOfSections {
    return self.sectionModels.count;
}

- (NSUInteger)numberOfCellModels {
    NSUInteger count = 0;
    for (HWTableSection *s in self.sectionModels) {
        count += [s numberOfCellModelsInSection];
    }
    return count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [self.sectionModels[section] numberOfCellModelsInSection];
}

- (void)addSection:(HWTableSection *)aSection {
    [self.sectionModels addObject:aSection];
}

- (void)insertSection:(HWTableSection *)aSection atIndex:(NSUInteger)index {
    [self.sectionModels insertObject:aSection atIndex:index];
}

- (void)removeLastSection {
    [self.sectionModels removeLastObject];
}

- (void)removeSectionAtIndex:(NSUInteger)index {
    [self.sectionModels removeObjectAtIndex:index];
}

- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(HWTableSection *)aSection {
    [self.sectionModels replaceObjectAtIndex:index withObject:aSection];
}

- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2 {
    [self.sectionModels exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (void)removeAllSections {
    [self.sectionModels removeAllObjects];
}

- (void)removeSection:(HWTableSection *)aSection {
    [self.sectionModels removeObject:aSection];
}

#pragma mark - Private

#pragma mark - Getters

@end
