//
//  UIApplication+HWAdd.h
//  HWCoreFramework
//
//  Created by 58 on 6/23/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (HWAdd)

@property (nonatomic, readonly) NSURL    *hw_documentsURL;
@property (nonatomic, readonly) NSString *hw_documentsPath;

@property (nonatomic, readonly) NSURL    *hw_cachesURL;
@property (nonatomic, readonly) NSString *hw_cachesPath;

@property (nonatomic, readonly) NSURL    *hw_libraryURL;
@property (nonatomic, readonly) NSString *hw_libraryPath;

@property (nonatomic, readonly) NSString *hw_appBundleName;

@property (nonatomic, readonly) NSString *hw_appBundleID;

@property (nonatomic, readonly) NSString *hw_appVersion;

@property (nonatomic, readonly) NSString *hw_appBuildVersion;

@end
