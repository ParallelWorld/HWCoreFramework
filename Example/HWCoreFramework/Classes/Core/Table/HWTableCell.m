
#import "HWTableCell.h"

@implementation HWTableCell

- (void)configureCellWithModel:(HWTableCellModel *)cellModel {
    _cellModel = cellModel;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(0, [self heightThatNotUseAutoLayout]);
}

- (CGFloat)heightThatNotUseAutoLayout {
    return -1;
}

@end
