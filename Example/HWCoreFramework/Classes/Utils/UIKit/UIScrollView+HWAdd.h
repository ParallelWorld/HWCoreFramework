
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
