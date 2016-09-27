//
//  SLTableViewController.m
//  HWCoreFramework
//
//  Created by 58 on 9/7/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLTableViewController.h"
#import "SLTableViewDataSource.h"
#import "SLTable1Cell.h"

@interface SLTableViewController ()
@property (nonatomic, strong) SLTableViewDataSource *dataSource;
@end

@implementation SLTableViewController

@dynamic dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.needFooter = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self pullRefreshWithAnimated:NO];
}

- (void)setupTableDataSource {
    self.dataSource = [SLTableViewDataSource new];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}

- (NSArray<Class> *)cellClassesContainedInTableView {
    return @[SLTable1Cell.class];
}

- (void)actionFromView:(UIView *)view eventIdentifier:(NSString *)eventIdentifier context:(void *)context {
    HW_LOG_VAR(eventIdentifier);
}

@end
