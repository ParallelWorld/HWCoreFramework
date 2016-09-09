//
//  SLTableViewDataSource.m
//  HWCoreFramework
//
//  Created by 58 on 9/7/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLTableViewDataSource.h"
#import "SLTable1CellModel.h"


@implementation SLTableViewDataSource {
    NSUInteger _loadMoreCount;
}


- (void)configureRefreshData:(id)data {
    [super configureRefreshData:data];
    HWTableSection *section = [HWTableSection new];
    for (int i = 0; i < 10; i++) {
        SLTable1CellModel *cellModel = [[SLTable1CellModel alloc] initWithDictionary:nil];
        cellModel.title = [@(i) stringValue];
        [section addCellModel:cellModel];
    }
    [self addSection:section];
}

- (void)configureLoadMoreData:(id)data {
    [super configureLoadMoreData:data];
    if (_loadMoreCount < 3) {
        self.canLoadMore = YES;
        HWTableSection *section = [HWTableSection new];
        for (int i = 0; i < 5; i++) {
            SLTable1CellModel *cellModel = [[SLTable1CellModel alloc] initWithDictionary:nil];
            cellModel.title = [@(i * _loadMoreCount) stringValue];
            [section addCellModel:cellModel];
        }
        [self addSection:section];
    } else {
        self.canLoadMore = NO;
        _loadMoreCount = 0;
    }
    _loadMoreCount++;
}

@end
