
#import "UIScrollView+HWAdd.h"

@implementation UIScrollView (HWAdd)

- (void)hw_scrollToTop {
    [self hw_scrollToTopAnimated:YES];
}

- (void)hw_scrollToBottom {
    [self hw_scrollToBottomAnimated:YES];
}

- (void)hw_scrollToLeft {
    [self hw_scrollToLeftAnimated:YES];
}

- (void)hw_scrollToRight {
    [self hw_scrollToRightAnimated:YES];
}

- (void)hw_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)hw_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)hw_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)hw_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
