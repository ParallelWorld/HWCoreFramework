
#import <Foundation/Foundation.h>

/// Identifier cell use auto layout.
extern const CGFloat HWTableCellModelUseAutoLayout;


@interface HWTableCellModel : NSObject

/// Default is `HWTableCellModelUseAutoLayout`. Cell should use auto layout. Cell height will be managed by pod of `FDTemplateLayoutCell`. The value of cellHeight is `HWTableCellModelUseAutoLayout`.
/// Otherwise, cell should use frame. The value of cellHeight is the true height of the cell.
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, copy, readonly) NSString *identifier;

@property (nonatomic, copy, readonly) NSDictionary *dic;

- (instancetype)initWithDictionary:(NSDictionary *)dic NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
