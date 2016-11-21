//
//  NSObject+HWAdd.h
//  HWCoreFramework
//
//  Created by 58 on 7/4/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HWAdd)
- (void)hw_decode:(NSCoder *)decoder;
- (void)hw_encode:(NSCoder *)encoder;

- (NSString *)hw_toString;

@end
