
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HWButtonAlignmentType) {
    HWButtonLeftImageRightTitle, // default
    HWButtonRightImageLeftTitle,
    HWButtonTopImageBottomTitle,
    HWButtonBottomImageTopTitle,
};

@interface UIButton (HWAdd)

- (void)hw_setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

/// Easy to Set the position relationship of the button's title and button's image.
- (void)hw_setContentWithSpace:(CGFloat)space forType:(HWButtonAlignmentType)type;

@end
