//
//  HWBaseListController.m
//  Pods
//
//  Created by 58 on 6/14/16.
//
//

#import "HWBaseTableController.h"
#import "HWBaseTableSource.h"
#import "Masonry.h"
#import "HWBaseTableCell.h"
#import "HWBaseCellModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MJRefresh.h"
#import "HWUtils.h"

@interface HWBaseTableController ()

@end

@implementation HWBaseTableController

- (NSArray *)cellClassesContainedInTableView {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupTableSource];
    
    NSAssert(self.tableView, @"tableView不能为空");
    NSAssert(self.tableSource, @"tableSource不能为空");

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableSource.delegate = self;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    for (Class cellClass in [self cellClassesContainedInTableView]) {
        NSString *cellIdentifier = [self.tableSource identifierForCellClass:cellClass];
        NSString *cellNibPath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
        if (cellNibPath) {
            [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:cellIdentifier];
        } else {
            [self.tableView registerClass:cellClass forCellReuseIdentifier:cellIdentifier];
        }
    }
}

- (void)refresh {
    [self.tableSource refreshSource];
}

- (void)pullDownToRefresh {
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupTableView {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)setupTableSource {
    [self doesNotRecognizeSelector:_cmd];
}

#pragma mark - HWBaseTableSourceDelegate

- (void)tableSourceDidStartRefresh:(HWBaseTableSource *)source {
    
}

- (void)tableSourceDidEndRefresh:(HWBaseTableSource *)source {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)tableSourceDidEndRefresh:(HWBaseTableSource *)source error:(NSError *)error {
    [self.tableView.mj_header endRefreshing];
}

- (void)tableSourceDidStartLoadMore:(HWBaseTableSource *)source {
    
}

- (void)tableSourceDidEndLoadMore:(HWBaseTableSource *)source {
    
}

- (void)tableSourceDidEndLoadMore:(HWBaseTableSource *)source error:(NSError *)error {
    
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HWBaseCellModel *cellModel = [self.tableSource cellModelAtIndexPath:indexPath];
    HWBaseTableCell *cell = (HWBaseTableCell *)[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    cell.actionDelegate = self;
    cell.cellModel = cellModel;
    [cell updateCell];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableSource numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableSource numberOfSections];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HWBaseCellModel *cellModel = [self.tableSource cellModelAtIndexPath:indexPath];
    return [tableView fd_heightForCellWithIdentifier:cellModel.identifier cacheByIndexPath:indexPath configuration:^(HWBaseTableCell *cell) {
        cell.cellModel = cellModel;
        [cell updateCell];
    }];
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
            [self.tableSource refreshSource];
        }];
    } else {
        self.tableView.mj_header = nil;
    }
}

#pragma mark - Getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}

@end
