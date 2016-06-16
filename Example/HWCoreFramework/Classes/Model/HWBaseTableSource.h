//
//  HWBaseTableSource.h
//  Pods
//
//  Created by 58 on 6/14/16.
//
//

#import <Foundation/Foundation.h>
#import "HWNetwork.h"

@class HWBaseCellModel;
@class HWBaseTableSource;
@class HWTableSection;

@protocol HWBaseTableSourceDelegate <NSObject>

@optional
- (void)tableSourceDidStartRefresh:(HWBaseTableSource *)source;
- (void)tableSourceDidEndRefresh:(HWBaseTableSource *)source;
- (void)tableSourceDidEndRefresh:(HWBaseTableSource *)source error:(NSError *)error;

- (void)tableSourceDidStartLoadMore:(HWBaseTableSource *)source;
- (void)tableSourceDidEndLoadMore:(HWBaseTableSource *)source;
- (void)tableSourceDidEndLoadMore:(HWBaseTableSource *)source error:(NSError *)error;

@end

@interface HWBaseTableSource : NSObject <HWNetworkRequestCallbackDelegate>

@property (nonatomic, weak) id <HWBaseTableSourceDelegate> delegate;

@property (nonatomic, strong) id <HWNetworkRequestProtocol> request;

/// 异步
- (void)prepareData:(id)data;

- (void)refreshSource;
- (void)loadMoreSource;


- (NSString *)identifierForCellClass:(Class)aClass;

- (HWBaseCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (NSInteger)numberOfSections;


- (void)addSection:(HWTableSection *)aSection;
- (void)insertSection:(HWTableSection *)aSection atIndex:(NSUInteger)index;
- (void)removeLastSection;
- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(HWTableSection *)aSection;
- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2;
- (void)removeAllSections;
- (void)removeSection:(HWTableSection *)aSection;

@end
