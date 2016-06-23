//
//  HWBaseTableCell.h
//  Pods
//
//  Created by 58 on 6/14/16.
//
//

#import <UIKit/UIKit.h>

@class HWCellModel;

@protocol HWCellToControllerActionDelegate <NSObject>

- (void)actionFromView:(UIView *)view eventTag:(NSString *)tag context:(id)context;

@end


@interface HWBaseTableCell : UITableViewCell

- (void)updateCell __attribute((objc_requires_super));

@property (nonatomic, weak) HWCellModel *cellModel;

@property (nonatomic, weak) id <HWCellToControllerActionDelegate> actionDelegate;

@end
