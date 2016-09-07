//
//  SLTestViewController.m
//  HWCoreFramework
//
//  Created by 58 on 9/1/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLTestViewController.h"
#import "SLButtonAlignmentViewController.h"
#import "SLApplicationViewController.h"
#import "SLTableViewController.h"

@interface SLTestViewController ()

@end

@implementation SLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)entryButtonAlignmentController:(id)sender {
    [self.navigationController pushViewController:[SLButtonAlignmentViewController new] animated:YES];
}
- (IBAction)entryApplicationController:(id)sender {
    [self.navigationController pushViewController:[SLApplicationViewController new] animated:YES];
}
- (IBAction)entryCoreTableController:(id)sender {
    [self.navigationController pushViewController:[SLTableViewController new] animated:YES];
}

@end
