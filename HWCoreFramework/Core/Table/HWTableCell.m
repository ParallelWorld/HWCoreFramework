
#import "HWTableCell.h"
#import "HWTableCellModel.h"

@implementation HWTableCell

- (void)configureCellWithModel:(HWTableCellModel *)cellModel {
    _cellModel = cellModel;
}

- (CGSize)sizeThatFits:(CGSize)size {
    if (self.cellModel.cellHeight == HWTableCellModelUseAutoLayout) {
        return [super sizeThatFits:size];
    }
    return CGSizeMake(0, self.cellModel.cellHeight);
}

@end
