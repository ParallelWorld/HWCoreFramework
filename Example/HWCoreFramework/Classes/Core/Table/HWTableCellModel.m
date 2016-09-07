
#import "HWTableCellModel.h"

@implementation HWTableCellModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _useAutoLayout = YES;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _dic = dic;
    }
    return self;
}

- (NSString *)identifier {
    return NSStringFromClass(self.class);
}

@end
