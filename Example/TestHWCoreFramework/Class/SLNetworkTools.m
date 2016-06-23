//
//  SLNetworkTools.m
//  HWCoreFramework
//
//  Created by 58 on 6/22/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLNetworkTools.h"

@implementation SLNetworkTools

+ (SLBaseRequest *)initRequest {
    return ({
        SLBaseRequest *r = [SLBaseRequest new];
        r.relativeURL = @"/api/system";
        r.requestMethod = HWNetworkRequestMethodGET;
        r.parameters = @{@"method" : @"system.ad.all",
                         @"v" : @"2.0"};
        r;
    });
}

@end
