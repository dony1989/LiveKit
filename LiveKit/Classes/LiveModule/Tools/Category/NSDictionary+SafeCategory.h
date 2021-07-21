//
//  NSDictionary+SafeCategory.h
//  PrivateTest
//
//  Created by don on 2021/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (SafeCategory)
+ (id)dictionaryWithObjectSafe:(id)object forKey:(id<NSCopying>)key;
- (id)objectForKeySafe:(id)aKey;
- (NSString *)stringForKeySafe:(id)akey;
- (NSNumber *)numberForKeySafe:(id)aKey;
- (NSInteger)integerForKeySafe:(id)aKey;
- (long long)longlongForKeySafe:(id)aKey;

- (BOOL)boolForKeySafe:(id)aKey;
- (NSArray *)arrayForKeySafe:(id)aKey;
- (NSDictionary *)dictionaryForKeySafe:(id)aKey;
@end

@interface NSMutableDictionary (SafeCategory)
- (void)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey;
@end
NS_ASSUME_NONNULL_END
