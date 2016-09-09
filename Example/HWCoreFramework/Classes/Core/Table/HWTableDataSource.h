
#import <Foundation/Foundation.h>
#import "HWNetwork.h"

@class HWTableCellModel;
@class HWTableDataSource;
@class HWTableSection;
@class HWTableSectionMaker;

NS_ASSUME_NONNULL_BEGIN


@protocol HWTableDataSourceDelegate <NSObject>

@optional

- (void)tableDataSourceDidStartRefresh:(HWTableDataSource *)source;
- (void)tableDataSourceDidFinishRefresh:(HWTableDataSource *)source;

- (void)tableDataSourceDidStartLoadMore:(HWTableDataSource *)source;
- (void)tableDataSourceDidFinishLoadMore:(HWTableDataSource *)source;

@end


@interface HWTableDataSource : NSObject

@property (nonatomic, weak) id <HWTableDataSourceDelegate> delegate;

@property (nonatomic, strong) NSError *error;

@property (nonatomic, strong) HWNetworkRequest *request;


@property (nonatomic, assign) BOOL canLoadMore;

- (void)refreshSource;
- (void)loadMoreSource;

- (void)configureRefreshData:(nullable id)data __attribute((objc_requires_super));
- (void)configureLoadMoreData:(nullable id)data __attribute((objc_requires_super));;




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

@interface HWTableDataSource (TableView)

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (__kindof HWTableCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)identifierForCellClass:(Class)aClass;

@end

NS_ASSUME_NONNULL_END
