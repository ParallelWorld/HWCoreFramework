//
//  SLHomeTableSource.m
//  HWCoreFramework
//
//  Created by 58 on 6/15/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLHomeTableSource.h"
#import "SLHomeCellModel.h"


@implementation SLHomeTableSource

- (void)prepareData:(id)data {
    [self addSection:({
        HWTableSection *s = [HWTableSection new];
        for (int i = 0; i < 100; i++) {
            SLHomeCellModel *m = [SLHomeCellModel new];
            m.title = [NSString stringWithFormat:@"第%@个", @(i)];
            [s addCellModel:m];
        }
        s;
    })];
}

@end
