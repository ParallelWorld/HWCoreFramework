
#import "HWTableController.h"
#import "HWTableDataSource.h"
#import "HWTableCell.h"
#import "HWTableCellModel.h"
#import "Masonry.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MJRefresh.h"
#import "HWUtils.h"

@interface HWTableController ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HWTableController

- (UITableViewStyle)tableViewStyle {
    return UITableViewStylePlain;
}

- (void)makeTableViewConstraints {
    if (!self.tableView.superview) return;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

- (NSArray<Class> *)cellClassesContainedInTableView {
    return nil;
}

- (void)setupTableDataSource {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init table view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:[self tableViewStyle]];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
    [self makeTableViewConstraints];
    
    // init table view data source.
    [self setupTableDataSource];
    
    NSAssert([self.dataSource isKindOfClass:[HWTableDataSource class]], @"The type of data source must be kind of `HWTableDataSource`.");
    
    // connect table view and table view data source.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.dataSource.delegate = self;
    
    // register cell classes
    for (Class cellClass in [self cellClassesContainedInTableView]) {
        NSString *cellIdentifier = [self.dataSource identifierForCellClass:cellClass];
        NSString *cellNibPath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
        if (cellNibPath) {
            [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:cellIdentifier];
        } else {
            [self.tableView registerClass:cellClass forCellReuseIdentifier:cellIdentifier];
        }
    }
}

- (void)refresh {
    [self.dataSource refreshSource];
}

- (void)pullDownToRefresh {
    [self.tableView.mj_header beginRefreshing];
}



#pragma mark - HWBaseTableSourceDelegate

- (void)tableSourceDidStartRefresh:(HWTableDataSource *)source {

}

- (void)tableSourceDidEndRefresh:(HWTableDataSource *)source {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)tableSourceDidEndRefresh:(HWTableDataSource *)source error:(NSError *)error {
    [self.tableView.mj_header endRefreshing];
}

- (void)tableSourceDidStartLoadMore:(HWTableDataSource *)source {
    
}

- (void)tableSourceDidEndLoadMore:(HWTableDataSource *)source {
    
}

- (void)tableSourceDidEndLoadMore:(HWTableDataSource *)source error:(NSError *)error {
    
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HWTableCellModel *cellModel = [self.dataSource cellModelAtIndexPath:indexPath];
    HWTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    cell.actionDelegate = self;
    cell.cellModel = cellModel;
    [cell updateCell];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSections];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HWTableCellModel *cellModel = [self.dataSource cellModelAtIndexPath:indexPath];
    if (cellModel.useAutoLayout) {
        return [tableView fd_heightForCellWithIdentifier:cellModel.identifier cacheByIndexPath:indexPath configuration:^(HWTableCell *cell) {
            cell.cellModel = cellModel;
            [cell updateCell];
        }];
    } else {
        return cellModel.cellHeight;
    }
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"No Data"];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return [self.dataSource numberOfCellModels] == 0;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self refresh];
}

#pragma mark - HWCellToControllerActionDelegate

- (void)actionFromView:(UIView *)view eventTag:(NSString *)tag context:(id)context {
    
}

#pragma mark - Setters

- (void)setNeedHeader:(BOOL)needHeader {
    _needHeader = needHeader;
    if (needHeader) {
        HW_WEAKIFY(self);
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            HW_STRONGIFY(self);
            [self.dataSource refreshSource];
        }];
    } else {
        self.tableView.mj_header = nil;
    }
}

#pragma mark - Getters

//- (UIRectEdge)edgesForExtendedLayout {
//    return UIRectEdgeNone;
//}

@end
