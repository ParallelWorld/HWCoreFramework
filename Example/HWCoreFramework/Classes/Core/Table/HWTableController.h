
#import "HWTableCell.h"
#import "HWTableDataSource.h"
#import "UIScrollView+EmptyDataSet.h"
#import "HWViewToControllerActionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HWTableController : UIViewController
<UITableViewDelegate, UITableViewDataSource, HWViewToControllerActionProtocol, HWTableSourceDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (nonatomic, assign) BOOL needHeader;
@property (nonatomic, assign) BOOL needFooter;

/// Table view.
@property (nonatomic, strong, readonly) UITableView *tableView;

/// Table controller's data source.
@property (nonatomic, strong) HWTableDataSource *dataSource;


- (void)pullDownToRefresh;
- (void)refresh;


/// Default is `UITableViewStylePlain`.
/// Subclass can overwrite this method.
- (UITableViewStyle)tableViewStyle;

/// Default is that table view's edges equal to self.view.
/// Subclass can overwrite this method to make your table view's constraints.
- (void)makeTableViewConstraints;

/// Default is no implementation.
/// Subclass should initialize your data source. The type must be kind of `HWTableDataSource`.
- (void)setupTableDataSource;

/// Default is return nil.
/// Subclass need return custom cell classes.
- (NSArray<Class> *)cellClassesContainedInTableView;

@end

NS_ASSUME_NONNULL_END
