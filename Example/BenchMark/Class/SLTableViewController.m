//
//  SLTableViewController.m
//  HWCoreFramework
//
//  Created by 58 on 9/7/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLTableViewController.h"
#import "SLTableViewDataSource.h"

@interface SLTableViewController ()
@property (nonatomic, strong) SLTableViewDataSource *dataSource;
@end

@implementation SLTableViewController

@dynamic dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor redColor];
}

- (void)setupTableDataSource {
    self.dataSource = [SLTableViewDataSource new];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}

@end
