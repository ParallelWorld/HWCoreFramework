
#import "HWTableController.h"
#import "HWTableDataSource.h"
#import "HWTableCell.h"
#import "HWTableCellModel.h"
#import "Masonry.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MJRefresh.h"
#import "HWUtils.h"

@interface HWTableController ()
@property (nonatomic, strong, readwrite) UITableView *tableView;
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
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)setupTableDataSource {
    [self doesNotRecognizeSelector:_cmd];
}

- (Class)customRefreshHeaderClass {
    return [MJRefreshNormalHeader class];
}

- (Class)customRefreshFooterClass {
    return [MJRefreshAutoNormalFooter class];
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    // init property
    self.needHeader = YES;
    self.needFooter = NO;
}

- (void)pullRefreshWithAnimated:(BOOL)animated {
    if (animated) {
        [self.tableView.mj_header beginRefreshing];
    } else {
        [self p_headerRefreshAction];
    }
}

- (void)loadMoreWithAnimated:(BOOL)animated {
    if (animated) {
        [self.tableView.mj_footer beginRefreshing];
    } else {
        [self p_footerRefreshAction];
    }
}

#pragma mark - HWTableDataSourceDelegate

- (void)tableDataSourceDidStartRefresh:(HWTableDataSource *)source {

}

- (void)tableDataSourceDidFinishRefresh:(HWTableDataSource *)source {
    [self.tableView.mj_header endRefreshing];
    if (source.canLoadMore) {
        [self.tableView.mj_footer resetNoMoreData];
    }
    [self.tableView reloadData];
}

- (void)tableDataSourceDidStartLoadMore:(HWTableDataSource *)source {

}

- (void)tableDataSourceDidFinishLoadMore:(HWTableDataSource *)source {
    if (source.canLoadMore) {
        [self.tableView.mj_footer endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HWTableCellModel *cellModel = [self.dataSource cellModelAtIndexPath:indexPath];
    HWTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    cell.actionDelegate = self;
    [cell configureCellWithModel:cellModel];
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
    if (cellModel.cellHeight == HWTableCellModelUseAutoLayout) {
        return [tableView fd_heightForCellWithIdentifier:cellModel.identifier cacheByIndexPath:indexPath configuration:^(HWTableCell *cell) {
            [cell configureCellWithModel:cellModel];
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
    return NO;
    return [self.dataSource numberOfCellModels] == 0;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
//    [self refresh];
}

#pragma mark - HWViewToControllerActionProtocol

- (void)actionFromView:(UIView *)view eventIdentifier:(NSString *)eventIdentifier context:(id)context {
    [self doesNotRecognizeSelector:_cmd];
}

#pragma mark - Setters

- (void)setNeedHeader:(BOOL)needHeader {
    _needHeader = needHeader;
    Class headerClass = [self customRefreshHeaderClass];
    NSAssert([headerClass isSubclassOfClass:MJRefreshHeader.class], @"Custom refresh header class must be subclass of `MJRefreshHeader`.");
    self.tableView.mj_header = !needHeader ? nil : [headerClass headerWithRefreshingTarget:self refreshingAction:@selector(p_headerRefreshAction)];
}

- (void)setNeedFooter:(BOOL)needFooter {
    _needFooter = needFooter;
    Class footerClass = [self customRefreshFooterClass];
    NSAssert([footerClass isSubclassOfClass:MJRefreshFooter.class], @"Custom refresh footer class must be subclass of `MJRefreshFooter`.");
    self.tableView.mj_footer = !needFooter ? nil : [footerClass footerWithRefreshingTarget:self refreshingAction:@selector(p_footerRefreshAction)];
}

#pragma mark - Getters

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

#pragma mark - Private method

- (void)p_headerRefreshAction {
    [self.dataSource refreshSource];
}

- (void)p_footerRefreshAction {
    [self.dataSource loadMoreSource];
}

@end
