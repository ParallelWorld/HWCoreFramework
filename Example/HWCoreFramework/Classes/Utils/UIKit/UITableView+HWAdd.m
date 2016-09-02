
#import "UITableView+HWAdd.h"

@implementation UITableView (HWAdd)

- (void)hw_registerCellClassOrNib:(NSString *)classNameOrNibName forCellReuseIdentifier:(NSString *)identifier {
    NSString *nibPath = [[NSBundle mainBundle] pathForResource:classNameOrNibName ofType:@"nib"];
    if (nibPath) {
        [self registerNib:[UINib nibWithNibName:classNameOrNibName bundle:nil] forCellReuseIdentifier:identifier];
    } else {
        [self registerClass:NSClassFromString(classNameOrNibName) forCellReuseIdentifier:identifier];
    }
}

- (void)hw_scrollToRow:(NSUInteger)row inSection:(NSUInteger)section atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}

- (void)hw_insertRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self hw_insertRowAtIndexPath:indexPath withRowAnimation:animation];
}

- (void)hw_reloadRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self hw_reloadRowAtIndexPath:indexPath withRowAnimation:animation];
}

- (void)hw_deleteRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self hw_deleteRowAtIndexPath:indexPath withRowAnimation:animation];
}

- (void)hw_insertRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)hw_reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)hw_deleteRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)hw_insertSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];
    [self insertSections:sections withRowAnimation:animation];
}

- (void)hw_reloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];
    [self reloadSections:sections withRowAnimation:animation];
}

- (void)hw_deleteSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];
    [self deleteSections:sections withRowAnimation:animation];
}

@end
