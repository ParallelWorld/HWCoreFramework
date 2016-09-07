
#import "HWTableCell.h"

@implementation HWTableCell

- (void)updateCell {
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(0, [self heightThatNotUseAutoLayout]);
}

- (CGFloat)heightThatNotUseAutoLayout {
    return -1;
}

@end
