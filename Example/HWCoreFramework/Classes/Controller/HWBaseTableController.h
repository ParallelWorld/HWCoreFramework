//
//  HWBaseListController.h
//  Pods
//
//  Created by 58 on 6/14/16.
//
//

#import <UIKit/UIKit.h>
#import "HWBaseTableCell.h"
#import "HWBaseTableSource.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HWBaseTableControllerDelegate <NSObject>

@required
- (NSArray * _Nullable)cellClassesContainedInTableView;
//- (UITableView *)hw_tableView;
//- (HWBaseTableSource *)hw_tableViewSource;
//
//@optional
//- (BOOL)hw_needPullDownRefresh;
//- (BOOL)hw_needPullUpRefresh;

@end

@interface HWBaseTableController : UIViewController <UITableViewDelegate, UITableViewDataSource, HWCellToControllerActionDelegate, HWBaseTableSourceDelegate>

//@property (nonatomic, weak) id <HWBaseTableControllerDelegate> delegate;

@property (nonatomic, assign) BOOL needHeader;
@property (nonatomic, assign) BOOL needFooter;

@property (nonatomic, strong, null_resettable) UITableView *tableView;

@property (nonatomic, strong) HWBaseTableSource *tableSource;

- (NSArray *)cellClassesContainedInTableView;

- (void)pullDownToRefresh;
- (void)refresh;

- (void)setupTableView;
- (void)setupTableSource;

@end

NS_ASSUME_NONNULL_END
