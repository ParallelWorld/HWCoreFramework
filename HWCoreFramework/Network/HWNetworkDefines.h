//
//  HWNetworkDefines.h
//  HWCoreFramework
//
//  Created by 58 on 6/15/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#ifndef HWNetworkDefines_h
#define HWNetworkDefines_h


@class HWNetworkRequest;
@class HWNetworkResponse;


typedef void(^HWNetworkRequestSuccessHandler)(HWNetworkResponse *response, id data);
typedef void(^HWNetworkRequestFailureHandler)(HWNetworkResponse *response, NSError *error);
typedef void(^HWNetworkRequestProgressHandler)(HWNetworkResponse *response, int64_t progress);


/// 请求方法
typedef NS_ENUM(NSUInteger, HWNetworkRequestMethod) {
    HWNetworkRequestMethodGET,
    HWNetworkRequestMethodPOST,
};


/// 请求校验器
@protocol HWNetworkRequestValidator <NSObject>
@required
- (BOOL)validateRequest:(HWNetworkRequest *)request;
@end


/// 请求转换器
@protocol HWNetworkRequestConvertor <NSObject>
@required
- (void)convertRequest:(HWNetworkRequest *)request;
@end


@protocol HWNetworkResponseValidator <NSObject>
@required
- (BOOL)validateResponse:(HWNetworkResponse *)response;
@end


@protocol HWNetworkResponseConvertor <NSObject>
@required
- (void)convertResponse:(HWNetworkResponse *)response;
@end

#endif /* HWNetworkDefines_h */
