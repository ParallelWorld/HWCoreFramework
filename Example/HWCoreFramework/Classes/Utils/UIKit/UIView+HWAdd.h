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

@property (nonatomic) CGFloat hw_left;
@property (nonatomic) CGFloat hw_top;
@property (nonatomic) CGFloat hw_right;
@property (nonatomic) CGFloat hw_bottom;
@property (nonatomic) CGFloat hw_width;
@property (nonatomic) CGFloat hw_height;
@property (nonatomic) CGFloat hw_centerX;
@property (nonatomic) CGFloat hw_centerY;
@property (nonatomic) CGPoint hw_origin;
@property (nonatomic) CGSize  hw_size;

@end
