//
//  HWTableCellModel.m
//  HWCoreFramework
//
//  Created by 58 on 8/17/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "HWTableCellModel.h"

@implementation HWTableCellModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _dic = dic;
    }
    return self;
}

- (NSString *)identifier {
    return NSStringFromClass(self.class);
}

@end
