//
//  NSArray+SafeCategory.h
//  PrivateTest
//
//  Created by don on 2021/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (SafeCategory)
+ (id)arrayWithObjectSafe:(id)anObject;
- (id)objectAtIndexSafe:(NSUInteger)uindex;
- (NSArray *)arrayByAddingObjectSafe:(id)anObject;
@end

@interface NSMutableArray (SafeCategory)
- (void)addObjectSafe:(id)anObject;
- (void)insertObjectSafe:(id)anObject atIndex:(NSUInteger)index;
- (void)replaceObjectAtIndexSafe:(NSUInteger)index withObject:(id)anObject;
- (void)removeObjectAtIndexSafe:(NSUInteger)index;
@end
NS_ASSUME_NONNULL_END
