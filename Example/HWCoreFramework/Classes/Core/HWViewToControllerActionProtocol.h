
#import <UIKit/UIKit.h>


@protocol HWViewToControllerActionProtocol <NSObject>

@required

/// View to controller action delegate.
///
/// @param view            the action where is from.
/// @param eventIdentifier to mark the action.
/// @param context         the data need to pass through.
- (void)actionFromView:(UIView *)view eventIdentifier:(NSString *)eventIdentifier context:(id)context;

@end
