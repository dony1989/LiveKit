//
//  UITableView+SafeCategory.h
//  PrivateTest
//
//  Created by don on 2021/7/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SafeCategory)
-(void)reloadRowsAtIndexPathsSafe:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
@end

NS_ASSUME_NONNULL_END
