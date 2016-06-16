//
//  SLHomeController.m
//  HWCoreFramework
//
//  Created by 58 on 6/14/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLHomeController.h"
#import "SLHomeCell.h"
#import "SLHomeTableSource.h"

@interface SLHomeController ()

@end

@implementation SLHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.needHeader = YES;
    self.needFooter = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self pullDownToRefresh];
}

- (NSArray *)cellClassesContainedInTableView {
    return @[SLHomeCell.class];
}

- (void)setupTableView {
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
}

- (void)setupTableSource {
    self.tableSource = [SLHomeTableSource new];
}

@end
