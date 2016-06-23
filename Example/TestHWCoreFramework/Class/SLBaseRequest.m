//
//  SLBaseRequest.m
//  HWCoreFramework
//
//  Created by 58 on 6/22/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLBaseRequest.h"
#import "SLNetworkRequestConvertor.h"

@implementation SLBaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.baseURL = @"http://bb.58v5.cn";
        self.requestConvertor = [SLNetworkRequestConvertor new];
    }
    return self;
}

@end
