//
//  NSString+SafeCategory.m
//  PrivateTest
//
//  Created by don on 2021/7/20.
//

#import "NSString+SafeCategory.h"

@implementation NSString (SafeCategory)
- (NSString *)substringFromIndexSafe:(NSUInteger)from {
    NSInteger start = from;
    if (start < 0) {
        return [self copy];
    }
    if (start > self.length) {
        return nil;
    }
    return [self substringFromIndex:from];
}
- (NSString *)substringToIndexSafe:(NSUInteger)to {
    NSInteger end = to;
    if (end < 0) {
        return nil;
    }
    if (end >= self.length) {
        return [self copy];
    }
    return [self substringToIndex:to];
}
- (NSString *)substringWithRangeSafe:(NSRange)range {
    if (range.location > self.length) {
        return nil;
    }
    if (range.location + range.length > self.length) {
        return [self substringWithRange:NSMakeRange(range.location, self.length - range.location)];
    }
    return [self substringWithRange:range];
}
- (NSString *)stringByReplacingCharactersInRangeSafe:(NSRange)range
                                          withString:(NSString *)replacement {
    if (range.location > self.length) {
        return nil;
    }
    if (range.location + range.length > self.length) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(range.location,self.length - range.location) withString:replacement];
    }
    return [self stringByReplacingCharactersInRange:range withString:replacement];
}

- (NSString *)stringByAppendingStringSafe:(NSString *)aString {
    if (!aString) {
        aString = @"";
    }
    return [self stringByAppendingString:aString];
}

- (double)doubleValueSafe {
    if (self && [self respondsToSelector:@selector(doubleValue)]) {
        return [self doubleValue];
    }
    return 0.0f;
}
- (float)floatValueSafe {
    if (self && [self respondsToSelector:@selector(floatValue)]) {
        return [self floatValue];
    }
    return 0.0f;
}
- (int)intValueSafe {
    if (self && [self respondsToSelector:@selector(intValue)]) {
        return [self intValue];
    }
    return 0;
}
- (NSInteger)integerValueSafe NS_AVAILABLE(10_5, 2_0) {
    if (self && [self respondsToSelector:@selector(integerValue)]) {
        return [self integerValue];
    }
    return 0;
}
- (long long)longLongValueSafe NS_AVAILABLE(10_5, 2_0) {
    if (self && [self respondsToSelector:@selector(longLongValue)]) {
        return [self longLongValue];
    }
    return 0L;
}
- (BOOL)boolValueSafe NS_AVAILABLE(10_5, 2_0) {
    if (self && [self respondsToSelector:@selector(boolValue)]) {
        return [self boolValue];
    }
    return false;
}
- (unichar)characterAtIndexSafe:(NSUInteger)index {
    if (self && [self respondsToSelector:@selector(characterAtIndexSafe:)]) {
        if (self.length > index) {
            return [self characterAtIndex:index];
        }
    }
    return 0;
}

@end
