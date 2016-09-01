
#import "UIButton+HWAdd.h"

@implementation UIButton (HWAdd)

- (void)hw_setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:image forState:state];
}

- (void)hw_setContentWithSpace:(CGFloat)space forType:(HWButtonAlignmentType)type {
    [self hw_resetEdgeInsets];

    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGSize titleSize = [self titleRectForContentRect:contentRect].size;
    CGSize imageSize = [self imageRectForContentRect:contentRect].size;
    
    CGFloat halfWidth = (titleSize.width + imageSize.width)/2;
    CGFloat halfHeight = (titleSize.height + imageSize.height)/2;
    
    switch (type) {
        case HWButtonLeftImageRightTitle: {
            [self setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, space, 0, -space)];
            break;
        }
        case HWButtonRightImageLeftTitle: {
            [self setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.width+space, 0, -titleSize.width-space)];
            break;
        }
        case HWButtonTopImageBottomTitle: {
            CGFloat contentTopInset = (titleSize.height > imageSize.height ? imageSize.height : halfHeight) + space;
            CGFloat contentLeftInset = titleSize.width > imageSize.width ? -imageSize.width : -halfWidth;
            CGFloat contentBottomInset = titleSize.height > imageSize.height ? 0 : -(imageSize.height - titleSize.height)/2;
            CGFloat contentRightInset = titleSize.width > imageSize.width ? 0 : (imageSize.width - titleSize.width)/2;
            
            CGFloat imageTopInset = -halfHeight-space;
            CGFloat imageLeftInset = halfWidth;
            CGFloat imageBottomInset = -imageTopInset;
            CGFloat imageRightInset = -imageLeftInset;
            
            [self setContentEdgeInsets:UIEdgeInsetsMake(contentTopInset, contentLeftInset, contentBottomInset, contentRightInset)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(imageTopInset, imageLeftInset, imageBottomInset, imageRightInset)];
            
            break;
        }
        case HWButtonBottomImageTopTitle: {
            CGFloat contentTopInset = titleSize.height > imageSize.height ? 0 : -(imageSize.height - titleSize.height)/2;
            CGFloat contentLeftInset = titleSize.width > imageSize.width ? -imageSize.width : -halfWidth;
            CGFloat contentBottomInset = (titleSize.height > imageSize.height ? imageSize.height : halfHeight) + space;
            CGFloat contentRightInset = titleSize.width > imageSize.width ? 0 : (imageSize.width - titleSize.width)/2;
            
            CGFloat imageTopInset = halfHeight+space;
            CGFloat imageLeftInset = halfWidth;
            CGFloat imageBottomInset = -imageTopInset;
            CGFloat imageRightInset = -imageLeftInset;
            
            [self setContentEdgeInsets:UIEdgeInsetsMake(contentTopInset, contentLeftInset, contentBottomInset, contentRightInset)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(imageTopInset, imageLeftInset, imageBottomInset, imageRightInset)];
            
            break;
        }
    }
}

- (void)hw_resetEdgeInsets {
    [self setContentEdgeInsets:UIEdgeInsetsZero];
    [self setImageEdgeInsets:UIEdgeInsetsZero];
    [self setTitleEdgeInsets:UIEdgeInsetsZero];
    [self layoutIfNeeded];
}

@end
