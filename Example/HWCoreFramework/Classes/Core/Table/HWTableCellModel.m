
#import "HWTableCellModel.h"

const CGFloat HWTableCellModelUseAutoLayout = -MAXFLOAT;

@implementation HWTableCellModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _cellHeight = HWTableCellModelUseAutoLayout;
        _dic = dic;
    }
    return self;
}

- (NSString *)identifier {
    return NSStringFromClass(self.class);
}

@end
