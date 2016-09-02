
#import <UIKit/UIKit.h>

@interface UITableView (HWAdd)

/// If nib file is exist, method will register nib of first parameter.
/// otherwise, method will register class of first parameter.
- (void)hw_registerCellClassOrNib:(NSString *)classNameOrNibName forCellReuseIdentifier:(NSString *)identifier;

- (void)hw_scrollToRow:(NSUInteger)row inSection:(NSUInteger)section atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;

- (void)hw_insertRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
- (void)hw_reloadRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
- (void)hw_deleteRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

- (void)hw_insertRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)hw_reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)hw_deleteRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

- (void)hw_insertSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
- (void)hw_reloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
- (void)hw_deleteSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

@end
