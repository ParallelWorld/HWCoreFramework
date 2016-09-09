
#import "HWTableCell.h"
#import "HWTableDataSource.h"
#import "UIScrollView+EmptyDataSet.h"
#import "HWViewToControllerActionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HWTableController : UIViewController <UITableViewDelegate, UITableViewDataSource, HWViewToControllerActionProtocol, HWTableDataSourceDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

/// Default is YES. When set YES, table view will add a header view which class is `customRefreshHeaderClass`.
@property (nonatomic, assign) BOOL needHeader;

/// Default is NO. When set YES, table view will add a footer view which class is `customRefreshFooterClass`.
@property (nonatomic, assign) BOOL needFooter;

/// Table view.
@property (nonatomic, strong, readonly) UITableView *tableView;

/// Table controller's data source.
@property (nonatomic, strong) HWTableDataSource *dataSource;

/// Pull refresh method.
- (void)pullRefreshWithAnimated:(BOOL)animated;

/// Load more method.
- (void)loadMoreWithAnimated:(BOOL)animated;

/// Default is `UITableViewStylePlain`.
/// Subclass can overwrite this method.
- (UITableViewStyle)tableViewStyle;

/// Default is that table view's edges equal to self.view.
/// Subclass can overwrite this method to make your table view's constraints.
- (void)makeTableViewConstraints;

/// Default is no implementation.
/// Subclass should initialize your data source. The type must be kind of `HWTableDataSource`.
- (void)setupTableDataSource;

/// Default is no implementation.
/// Subclass need return custom cell classes.
- (NSArray<Class> *)cellClassesContainedInTableView;

/// Should be the subclass of `MJRefreshHeader`.
/// Subclass can override this method to return custom refresh header.
/// Default return is `MJRefreshNormalHeader`.
- (Class)customRefreshHeaderClass;

/// Should be the subclass of `MJRefreshFooter`.
/// Subclass can override this method to return custom refresh footer.
/// Default return is `MJRefreshAutoNormalFooter`.
- (Class)customRefreshFooterClass;

@end

NS_ASSUME_NONNULL_END
