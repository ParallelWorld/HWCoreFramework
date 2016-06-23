//
//  HWBaseTableSource.m
//  Pods
//
//  Created by 58 on 6/14/16.
//
//

#import "HWTableSource.h"
#import "HWUtils.h"
#import "HWTableSection.h"

@interface HWTableSource ()

@property (nonatomic, strong) NSMutableArray<HWTableSection *> *sectionModels;

@end

@implementation HWTableSource

- (void)refreshSource {
    [self _notifyDelegateDidStartRefresh];
    
    if (!self.request) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self prepareData:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self _notifyDelegateDidEndRefresh];
            });
        });
    } else {
        HW_WEAKIFY(self);
        [self.request startWithSuccessHandler:^(HWNetworkResponse * _Nonnull response, id  _Nonnull data) {
            HW_STRONGIFY(self);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self prepareData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self _notifyDelegateDidEndRefresh];
                });
            });
        } failureHandler:^(HWNetworkResponse * _Nonnull response, NSError * _Nonnull error) {
            HW_STRONGIFY(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self _notifyDelegateDidEndRefreshWithError:error];
            });
        }];
    }
}

- (void)loadMoreSource {
    [self _notifyDelegateDidStartLoadMore];
    
    if (!self.request) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self prepareData:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self _notifyDelegateDidEndLoadMore];
            });
        });
    } else {
        HW_WEAKIFY(self);
        [self.request startWithSuccessHandler:^(HWNetworkResponse * _Nonnull response, id  _Nonnull data) {
            HW_STRONGIFY(self);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self prepareData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self _notifyDelegateDidEndLoadMore];
                });
            });
        } failureHandler:^(HWNetworkResponse * _Nonnull response, NSError * _Nonnull error) {
            HW_STRONGIFY(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self _notifyDelegateDidEndLoadMoreWithError:error];
            });
        }];
    }
}

- (void)prepareData:(id)data {
    [self doesNotRecognizeSelector:_cmd];
}

- (NSString *)identifierForCellClass:(Class)aClass {
    return [NSStringFromClass(aClass) stringByReplacingOccurrencesOfString:@"Cell" withString:@"CellModel"];
}

- (HWCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath {
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

- (void)_notifyDelegateDidStartRefresh {
    if ([self.delegate respondsToSelector:@selector(tableSourceDidStartRefresh:)]) {
        [self.delegate tableSourceDidStartRefresh:self];
    }
}

- (void)_notifyDelegateDidEndRefresh {
    if ([self.delegate respondsToSelector:@selector(tableSourceDidEndRefresh:)]) {
        [self.delegate tableSourceDidEndRefresh:self];
    }
}

- (void)_notifyDelegateDidEndRefreshWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(tableSourceDidEndRefresh:error:)]) {
        [self.delegate tableSourceDidEndRefresh:self error:error];
    }
}

- (void)_notifyDelegateDidStartLoadMore {
    if ([self.delegate respondsToSelector:@selector(tableSourceDidStartLoadMore:)]) {
        [self.delegate tableSourceDidStartLoadMore:self];
    }
}

- (void)_notifyDelegateDidEndLoadMore {
    if ([self.delegate respondsToSelector:@selector(tableSourceDidEndLoadMore:)]) {
        [self.delegate tableSourceDidEndLoadMore:self];
    }
}

- (void)_notifyDelegateDidEndLoadMoreWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(tableSourceDidEndLoadMore:error:)]) {
        [self.delegate tableSourceDidEndLoadMore:self error:error];
    }
}

#pragma mark - Getters

- (NSMutableArray<HWTableSection *> *)sectionModels {
    if (!_sectionModels) {
        _sectionModels = [NSMutableArray new];
    }
    return _sectionModels;
}

@end
