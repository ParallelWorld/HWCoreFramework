//
//  SLNetworkRequestConvertor.m
//  HWCoreFramework
//
//  Created by 58 on 6/22/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLNetworkRequestConvertor.h"
#import <CommonCrypto/CommonDigest.h>


@implementation SLNetworkRequestConvertor

- (void)convertRequest:(HWNetworkRequest *)request {
    NSMutableDictionary *parameters = request.parameters.mutableCopy;
    parameters[@"appKey"] = @"76532";
    parameters[@"appVersion"] = @"10256";
    parameters[@"platform"] = @"ios";
    parameters[@"sign"] = [self makeSign:parameters];
    request.parameters = parameters;
}

- (NSString *)makeSign:(NSDictionary *)dic
{
    NSString *sortedString = [self sortedStringInDic:dic];
    NSString *signedString = [self sha1String:sortedString];
    return [signedString uppercaseString];
}

- (NSString *)sortedStringInDic:(NSDictionary *)dic
{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [array addObject:[NSString stringWithFormat:@"%@%@",key,obj]];
    }];
    NSArray * sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];
    }];
    NSMutableString * resultStr = [[NSMutableString alloc] init];
    [sortedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [resultStr appendString:obj];
    }];
    
    return [NSString stringWithFormat:@"%@%@%@",@"KUEADF3",resultStr,@"KUEADF3"];
}

- (NSString *)sha1String:(NSString *)string
{
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x",digest[i]];
    }
    return  output;
}

@end
