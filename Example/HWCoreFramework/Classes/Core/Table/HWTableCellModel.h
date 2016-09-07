
#import <Foundation/Foundation.h>

@interface HWTableCellModel : NSObject

/// Default is YES.
@property (nonatomic, assign) BOOL useAutoLayout;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, copy, readonly) NSString *identifier;

@property (nonatomic, copy, readonly) NSDictionary *dic;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
