//
//  StringUtility.m
//  PrivateTest
//
//  Created by don on 2021/8/9.
//

#import "StringUtility.h"

@implementation StringUtility
+ (BOOL)isStringNotEmptyOrNil:(NSString *)string {
    if (string == nil || ![string isKindOfClass:[NSString class]]) {
        return NO;
    }
    return string.length > 0 ;
}
@end
