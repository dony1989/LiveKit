//
//  NSNumber+SafeCategory.h
//  PrivateTest
//
//  Created by don on 2021/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (SafeCategory)
- (char)charValueSafe;
- (unsigned char)unsignedCharValueSafe;
- (short)shortValueSafe;
- (unsigned short)unsignedShortValueSafe;
- (int)intValueSafe;
- (unsigned int)unsignedIntValueSafe;
- (long)longValueSafe;
- (unsigned long)unsignedLongValueSafe;
- (long long)longLongValueSafe;
- (unsigned long long)unsignedLongLongValueSafe;
- (float)floatValueSafe;
- (double)doubleValueSafe;
- (BOOL)boolValueSafe;
- (NSInteger)integerValueSafe;
- (NSUInteger)unsignedIntegerValueSafe;
@end

NS_ASSUME_NONNULL_END
