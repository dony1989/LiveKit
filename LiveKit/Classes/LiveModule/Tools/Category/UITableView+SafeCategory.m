//
//  UITableView+SafeCategory.m
//  PrivateTest
//
//  Created by don on 2021/7/20.
//

#import "UITableView+SafeCategory.h"

@implementation UITableView (SafeCategory)
- (void)reloadRowsAtIndexPathsSafe:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:indexPaths.count];
    NSInteger totalSelections = [self numberOfSections];
    for (NSIndexPath *indexPath in indexPaths) {
        NSInteger totalRows = [self numberOfRowsInSection:indexPath.section];
        if (indexPath.section < 0 || indexPath.section >= totalSelections ||
            indexPath.row >= totalRows) {
        } else {
            [tempArray addObject:indexPath];
        }
    }
    [self reloadRowsAtIndexPaths:tempArray withRowAnimation:animation];
}
@end
