//
//  CookieUtility.h
//  YuwenParent
//
//  Created by xiaoshuang on 2019/3/29.
//  Copyright © 2019年 xiaoshuang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CookieUtility : NSObject

+ (void)logAllCookies;
+ (void)addCookiesWithDomain:(NSString*)domain withCookies:(NSArray*)cookieArray;
+ (void)updateCookieByName:(NSString *)cookieName withValue:(NSString *)value;
+ (void)updateCookieByName:(NSString *)cookieName withValue:(NSString *)value domain:(NSString *)domain path:(NSString *)path expiresDate:(NSDate *)expiresDate;
+ (void)clearAllCookies;

@end

NS_ASSUME_NONNULL_END
