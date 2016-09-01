
#import "HWTableRow.h"

@implementation HWTableRow

- (instancetype)initWithCellModel:(HWTableCellModel *)cellModel {
    self = [super init];
    if (self) {
        _cellModel = cellModel;
    }
    return self;
}

@end
