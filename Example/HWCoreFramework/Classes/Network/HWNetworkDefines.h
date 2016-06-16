//
//  HWNetworkDefines.h
//  HWCoreFramework
//
//  Created by 58 on 6/15/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#ifndef HWNetworkDefines_h
#define HWNetworkDefines_h

@protocol HWNetworkRequestProtocol;

typedef NS_ENUM(NSUInteger, HWNetworkRequestMethod) {
    HWNetworkRequestMethodGET,
    HWNetworkRequestMethodPOST,
};


@protocol HWNetworkRequestCallbackDelegate <NSObject>

@optional
- (void)networkRequest:(id <HWNetworkRequestProtocol>)request callbackSuccessWithData:(id)data;
- (void)networkRequest:(id <HWNetworkRequestProtocol>)request callbackFailureWithError:(NSError *)error;

@end
                                  

@protocol HWNetworkRequestProtocol <NSObject>

@required
- (HWNetworkRequestMethod)requestMethod;
- (NSString *)baseURL;
- (NSString *)relativeURL;
- (NSDictionary *)parameters;
- (void)start;
- (void)cancel;

@property (nonatomic, weak) id <HWNetworkRequestCallbackDelegate> callbackDelegate;

@property (nonatomic, copy) void (^callbackSuccessHandler)(id data);

@property (nonatomic, copy) void (^callbackFailureHandler)(NSError *error);

@optional
//- (NSTimeInterval)timeoutInterval;
//- (id <HWNRequestValidator>)requestValidator;
//- (id <HWNRequestConvertor>)requestConvertor;

@end

#endif /* HWNetworkDefines_h */
