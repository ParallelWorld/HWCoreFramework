//
//  HWNetworkResponse.h
//  HWCoreFramework
//
//  Created by 58 on 6/22/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWNetworkResponse : NSObject

@property (nonatomic, strong) id data;

@property (nonatomic, strong) NSError *error;

@end
