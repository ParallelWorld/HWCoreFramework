
#import <Foundation/Foundation.h>
#import "HWNetwork.h"

@class HWTableCellModel;
@class HWTableDataSource;
@class HWTableSection;
@class HWTableSectionMaker;

NS_ASSUME_NONNULL_BEGIN

@protocol HWTableSourceDelegate <NSObject>

@optional
- (void)tableSourceDidStartRefresh:(HWTableDataSource *)source;
- (void)tableSourceDidEndRefresh:(HWTableDataSource *)source;
- (void)tableSourceDidEndRefresh:(HWTableDataSource *)source error:(NSError *)error;

- (void)tableSourceDidStartLoadMore:(HWTableDataSource *)source;
- (void)tableSourceDidEndLoadMore:(HWTableDataSource *)source;
- (void)tableSourceDidEndLoadMore:(HWTableDataSource *)source error:(NSError *)error;

@end

@interface HWTableDataSource : NSObject

@property (nonatomic, weak) id <HWTableSourceDelegate> delegate;

@property (nonatomic, strong) HWNetworkRequest *request;

/// 异步
- (void)prepareData:(id)data;

- (void)refreshSource;
- (void)loadMoreSource;


- (NSString *)identifierForCellClass:(Class)aClass;



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
- (nullable __kindof HWTableCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
