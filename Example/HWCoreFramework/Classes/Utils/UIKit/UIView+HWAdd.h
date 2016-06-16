//
//  UIView+HWAdd.h
//  HWCoreFramework
//
//  Created by 58 on 6/16/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HWAdd)

+ (void)hw_dismissKeyboard;

- (void)hw_removeAllSubviews;

@property (nonatomic, readonly) UIViewController *hw_viewController;

@end
