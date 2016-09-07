
#import <UIKit/UIKit.h>
#import "HWViewToControllerActionProtocol.h"

@class HWTableCellModel;

@interface HWTableCell : UITableViewCell

- (void)updateCell __attribute((objc_requires_super));

@property (nonatomic, weak) HWTableCellModel *cellModel;

@property (nonatomic, weak) id <HWViewToControllerActionProtocol> actionDelegate;

/// If cell model's `useAutoLayout` is NO, framework will call this method.
/// Default is return -1;
- (CGFloat)heightThatNotUseAutoLayout;

@end
