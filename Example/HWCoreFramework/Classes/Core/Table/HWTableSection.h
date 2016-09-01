
#import <Foundation/Foundation.h>

@class HWCellModel;

@interface HWTableSection : NSObject

@property (nonatomic, copy) NSString *identifier;

- (NSInteger)numberOfCellModelsInSection;
- (HWCellModel *)cellModelAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfCellModel:(HWCellModel *)aCellModel;

- (void)addCellModel:(HWCellModel *)aCellModel;
- (void)insertCellModel:(HWCellModel *)aCellModel atIndex:(NSUInteger)index;
- (void)removeLastCellModel;
- (void)removeCellModelAtIndex:(NSUInteger)index;
- (void)replaceCellModelAtIndex:(NSUInteger)index withCellModel:(HWCellModel *)aCellModel;
- (void)exchangeCellModelAtIndex:(NSUInteger)idx1 withCellModelAtIndex:(NSUInteger)idx2;
- (void)removeAllCellModels;
- (void)removeCellModel:(HWCellModel *)aCellModel;

@end
