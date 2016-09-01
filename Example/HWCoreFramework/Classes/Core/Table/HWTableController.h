//
//  HWBaseListController.h
//  Pods
//
//  Created by 58 on 6/14/16.
//
//

#import "HWTableCell.h"
#import "HWTableSource.h"
#import "UIScrollView+EmptyDataSet.h"


NS_ASSUME_NONNULL_BEGIN

@interface HWTableController : UIViewController
<UITableViewDelegate, UITableViewDataSource, HWCellToControllerActionDelegate, HWTableSourceDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (nonatomic, assign) BOOL needHeader;
@property (nonatomic, assign) BOOL needFooter;

@property (nonatomic, strong, null_resettable) UITableView *tableView;

@property (nonatomic, strong) HWTableSource *tableSource;

- (NSArray *)cellClassesContainedInTableView;

- (void)pullDownToRefresh;
- (void)refresh;

- (void)setupTableView;
- (void)setupTableSource;

@end

NS_ASSUME_NONNULL_END
