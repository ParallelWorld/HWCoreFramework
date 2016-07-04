//
//  HWBaseTableSource.h
//  Pods
//
//  Created by 58 on 6/14/16.
//
//

#import <Foundation/Foundation.h>
#import "HWNetwork.h"

@class HWCellModel;
@class HWTableSource;
@class HWTableSection;

@protocol HWTableSourceDelegate <NSObject>

@optional
- (void)tableSourceDidStartRefresh:(HWTableSource *)source;
- (void)tableSourceDidEndRefresh:(HWTableSource *)source;
- (void)tableSourceDidEndRefresh:(HWTableSource *)source error:(NSError *)error;

- (void)tableSourceDidStartLoadMore:(HWTableSource *)source;
- (void)tableSourceDidEndLoadMore:(HWTableSource *)source;
- (void)tableSourceDidEndLoadMore:(HWTableSource *)source error:(NSError *)error;

@end

@interface HWTableSource : NSObject

@property (nonatomic, weak) id <HWTableSourceDelegate> delegate;

@property (nonatomic, strong) HWNetworkRequest *request;

/// 异步
- (void)prepareData:(id)data;

- (void)refreshSource;
- (void)loadMoreSource;


- (NSString *)identifierForCellClass:(Class)aClass;

- (HWCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (NSInteger)numberOfSections;

- (NSUInteger)numberOfCellModels;


- (void)addSection:(HWTableSection *)aSection;
- (void)insertSection:(HWTableSection *)aSection atIndex:(NSUInteger)index;
- (void)removeLastSection;
- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(HWTableSection *)aSection;
- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2;
- (void)removeAllSections;
- (void)removeSection:(HWTableSection *)aSection;

@end
