//
//  NSKeyedUnarchiver+HWAdd.h
//  HWCoreFramework
//
//  Created by 58 on 6/23/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSKeyedUnarchiver (HWAdd)

+ (id)hw_unarchiveObjectWithData:(NSData *)data exception:(NSException **)exception;

+ (id)hw_unarchiveObjectWithFile:(NSString *)path exception:(NSException **)exception;

@end
