//
//  UIScrollView+HWAdd.h
//  HWCoreFramework
//
//  Created by 58 on 6/23/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HWAdd)

- (void)hw_scrollToTop;

- (void)hw_scrollToBottom;

- (void)hw_scrollToLeft;

- (void)hw_scrollToRight;

- (void)hw_scrollToTopAnimated:(BOOL)animated;

- (void)hw_scrollToBottomAnimated:(BOOL)animated;

- (void)hw_scrollToLeftAnimated:(BOOL)animated;

- (void)hw_scrollToRightAnimated:(BOOL)animated;

@end
