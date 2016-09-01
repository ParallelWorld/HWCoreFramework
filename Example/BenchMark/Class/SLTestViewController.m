//
//  SLTestViewController.m
//  HWCoreFramework
//
//  Created by 58 on 9/1/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLTestViewController.h"
#import "SLButtonAlignmentViewController.h"

@interface SLTestViewController ()

@end

@implementation SLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)entryButtonAlignmentController:(id)sender {
    [self.navigationController pushViewController:[SLButtonAlignmentViewController new] animated:YES];
}

@end
