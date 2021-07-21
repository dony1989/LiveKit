//
//  NSString+SafeCategory.h
//  PrivateTest
//
//  Created by don on 2021/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SafeCategory)
- (NSString *)substringFromIndexSafe:(NSUInteger)from;
- (NSString *)substringToIndexSafe:(NSUInteger)to;
- (NSString *)substringWithRangeSafe:(NSRange)range;
- (NSString *)stringByReplacingCharactersInRangeSafe:(NSRange)range withString:(NSString *)replacement;

- (NSString *)stringByAppendingStringSafe:(NSString *)aString;

- (double)doubleValueSafe;
- (float)floatValueSafe;
- (int)intValueSafe;
- (NSInteger)integerValueSafe NS_AVAILABLE(10_5, 2_0);
- (long long)longLongValueSafe NS_AVAILABLE(10_5, 2_0);
- (BOOL)boolValueSafe NS_AVAILABLE(10_5, 2_0);

- (unichar)characterAtIndexSafe:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
