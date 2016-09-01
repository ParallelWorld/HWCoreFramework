
#import <Foundation/Foundation.h>

@interface HWTableCellModel : NSObject

@property (nonatomic, copy, readonly) NSString *identifier;

@property (nonatomic, copy, readonly) NSDictionary *dic;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
