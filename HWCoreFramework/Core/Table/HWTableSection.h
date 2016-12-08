
#import <Foundation/Foundation.h>

@class HWTableCellModel;

@interface HWTableSection : NSObject

/// Identify what the section is.
@property (nonatomic, copy) NSString *identifier;

- (NSInteger)numberOfCellModelsInSection;
- (__kindof HWTableCellModel *)cellModelAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfCellModel:(HWTableCellModel *)aCellModel;

- (void)addCellModel:(HWTableCellModel *)aCellModel;
- (void)insertCellModel:(HWTableCellModel *)aCellModel atIndex:(NSUInteger)index;
- (void)removeLastCellModel;
- (void)removeCellModelAtIndex:(NSUInteger)index;
- (void)replaceCellModelAtIndex:(NSUInteger)index withCellModel:(HWTableCellModel *)aCellModel;
- (void)exchangeCellModelAtIndex:(NSUInteger)idx1 withCellModelAtIndex:(NSUInteger)idx2;
- (void)removeAllCellModels;
- (void)removeCellModel:(HWTableCellModel *)aCellModel;

@end
