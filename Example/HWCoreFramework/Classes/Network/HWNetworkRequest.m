//
//  HWRequest.m
//  HWCoreFramework
//
//  Created by 58 on 6/22/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "HWNetworkRequest.h"
#import "AFNetworking.h"
#import "HWUtils.h"
#import "HWNetworkResponse.h"


@interface HWNetworkRequest ()

@property (nonatomic, copy) HWNetworkRequestSuccessHandler successHandler;
@property (nonatomic, copy) HWNetworkRequestFailureHandler failureHandler;
@property (nonatomic, copy) HWNetworkRequestProgressHandler progressHandler;

@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic, copy) NSString *URLString;

@end

@interface _HWNetworkClient : NSObject

HW_SINGLETON_INTERFACE(_HWNetworkClient)

@property (nonatomic, strong) AFHTTPSessionManager *manager;
- (void)startRequest:(HWNetworkRequest *)request;
- (void)cancelRequest:(HWNetworkRequest *)request;

@end

@implementation _HWNetworkClient

HW_SINGLETON_IMPLEMENTATION(_HWNetworkClient)

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void)startRequest:(HWNetworkRequest *)request {
    // Base check
    NSAssert(request.requestMethod == HWNetworkRequestMethodGET ||
             request.requestMethod == HWNetworkRequestMethodPOST,
             @"request method is not valid!");
    
    // 校验
    if (request.requestValidator) {
        [request.requestValidator validateRequest:request];
    }
    
    // 转换
    if (request.requestConvertor) {
        [request.requestConvertor convertRequest:request];
    }
    
    // 组装回调
    HW_WEAKIFY(self)
    HW_WEAKIFY(request)
    void (^successBlock)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask * task, id responseObject) {
        HW_STRONGIFY(self)
        HW_STRONGIFY(request)
        [self _request:request successWithResponseObject:responseObject];
    };
    
    void (^failureBlock)(NSURLSessionDataTask * task, NSError * error) = ^(NSURLSessionDataTask * task, NSError * error) {
        HW_STRONGIFY(self)
        HW_STRONGIFY(request)
        [self _request:request failureWithError:error];
    };
    
    void (^progressBlock)(NSProgress *progress) = ^(NSProgress *progress) {
        HW_STRONGIFY(self)
        HW_STRONGIFY(request)
        if (progress.totalUnitCount <= 0) {
            return;
        }
        [self _request:request progress:progress.totalUnitCount];
    };
    
    switch (request.requestMethod) {
        case HWNetworkRequestMethodGET: {
            request.task = [[_HWNetworkClient shared_HWNetworkClientInstance].manager GET:request.URLString
                                                               parameters:request.parameters
                                                                 progress:progressBlock
                                                                  success:successBlock
                                                                  failure:failureBlock];
            break;
        }
        case HWNetworkRequestMethodPOST: {
            request.task = [[_HWNetworkClient shared_HWNetworkClientInstance].manager POST:request.URLString
                                                                parameters:request.parameters
                                                                  progress:progressBlock
                                                                   success:successBlock
                                                                   failure:failureBlock];
            break;
        }
    }
}

- (void)cancelRequest:(HWNetworkRequest *)request {
    [request.task cancel];
}

#pragma mark - Private method

- (void)_request:(HWNetworkRequest *)request successWithResponseObject:(id)responseObject {
    HWNetworkResponse *res = [HWNetworkResponse new];
    res.data = responseObject;
    res.error = nil;
    
    request.response = res;
    
    if (request.responseValidator) {
        [request.responseValidator validateResponse:res];
    }
    
    if (request.responseConvertor) {
        [request.responseConvertor convertResponse:res];
    }
    
    if (request.response.error) {
        request.failureHandler(request.response, request.response.error);
    } else {
        request.successHandler(request.response, request.response.data);
    }
}

- (void)_request:(HWNetworkRequest *)request failureWithError:(NSError *)error {
    HWNetworkResponse *res = [HWNetworkResponse new];
    res.data = nil;
    res.error = error;
    
    request.response = res;
    
    if (request.responseValidator) {
        [request.responseValidator validateResponse:res];
    }
    
    if (request.responseConvertor) {
        [request.responseConvertor convertResponse:res];
    }
    
    if (request.response.error) {
        request.failureHandler(request.response, request.response.error);
    } else {
        request.successHandler(request.response, request.response.data);
    }
}

- (void)_request:(HWNetworkRequest *)request progress:(int64_t)progress {
    if (request.progressHandler) {
        request.progressHandler(request.response, progress);
    }
}

@end


@implementation HWNetworkRequest

- (void)startWithSuccessHandler:(HWNetworkRequestSuccessHandler)success
                 failureHandler:(HWNetworkRequestFailureHandler)failure
                progressHandler:(HWNetworkRequestProgressHandler)progress {
    self.successHandler  = success;
    self.failureHandler  = failure;
    self.progressHandler = progress;
    [[_HWNetworkClient shared_HWNetworkClientInstance] startRequest:self];
}

- (void)startWithSuccessHandler:(HWNetworkRequestSuccessHandler)success failureHandler:(HWNetworkRequestFailureHandler)failure {
    [self startWithSuccessHandler:success failureHandler:failure progressHandler:nil];
}

- (void)cancel {
    [[_HWNetworkClient shared_HWNetworkClientInstance] cancelRequest:self];
}

- (NSString *)URLString {
    return [self.baseURL stringByAppendingString:self.relativeURL];
}

@end
