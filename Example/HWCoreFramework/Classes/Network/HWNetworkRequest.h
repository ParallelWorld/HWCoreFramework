//
//  HWRequest.h
//  HWCoreFramework
//
//  Created by 58 on 6/22/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWNetworkDefines.h"

@class HWNetworkResponse;

NS_ASSUME_NONNULL_BEGIN

@interface HWNetworkRequest : NSObject

@property (nonatomic, copy) NSString *baseURL;
@property (nonatomic, copy) NSString *relativeURL;
@property (nonatomic, copy, readonly) NSString *URLString;
@property (nonatomic, copy) NSDictionary *parameters;
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, assign) HWNetworkRequestMethod requestMethod;

@property (nonatomic, strong) HWNetworkResponse *response;

@property (nonatomic, strong) id <HWNetworkRequestValidator> requestValidator;
@property (nonatomic, strong) id <HWNetworkRequestConvertor> requestConvertor;

@property (nonatomic, strong) id <HWNetworkResponseValidator> responseValidator;
@property (nonatomic, strong) id <HWNetworkResponseConvertor> responseConvertor;

- (void)startWithSuccessHandler:(HWNetworkRequestSuccessHandler)success
                 failureHandler:(HWNetworkRequestFailureHandler)failure
                progressHandler:(HWNetworkRequestProgressHandler _Nullable)progress;
- (void)startWithSuccessHandler:(HWNetworkRequestSuccessHandler)success
                 failureHandler:(HWNetworkRequestFailureHandler)failure;
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
