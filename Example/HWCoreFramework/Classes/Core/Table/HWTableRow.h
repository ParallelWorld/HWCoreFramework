
#import <Foundation/Foundation.h>
@class HWTableCellModel;

NS_ASSUME_NONNULL_BEGIN

@interface HWTableRow : NSObject

@property (nonatomic, strong, readonly) HWTableCellModel *cellModel;

- (instancetype)initWithCellModel:(HWTableCellModel *)cellModel NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
