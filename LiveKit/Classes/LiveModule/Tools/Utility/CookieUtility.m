//
//  CookieUtility.m
//  YuwenParent
//
//  Created by xiaoshuang on 2019/3/29.
//  Copyright © 2019年 xiaoshuang. All rights reserved.
//

#import "CookieUtility.h"
#import "NSDictionary+SafeCategory.h"
#import "StringUtility.h"

@implementation CookieUtility

+ (void)logAllCookies {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookiesArray = [storage cookies];
    for (int i = 0; i < cookiesArray.count; i++) {
        NSLog(@"----%s------>%@",__func__,cookiesArray[i]);
    }
}

+ (void)addCookiesWithDomain:(NSString*)domain withCookies:(NSArray*)cookieArray {
    NSHTTPCookie* cookie = nil;
    NSDictionary* properties = nil;
    NSString* cookieStr = nil;
    for (int i=0; i<[cookieArray count]; i++) {
        cookieStr = [cookieArray objectAtIndex:i];
        NSRange range = [cookieStr rangeOfString:@"="];
        if(range.location != NSNotFound) {
            properties = @{NSHTTPCookieName:[cookieStr substringToIndex:range.location], NSHTTPCookieValue:[cookieStr substringFromIndex:range.location+range.length], NSHTTPCookiePath:@"/", NSHTTPCookieDomain:domain, NSHTTPCookieExpires:[NSDate distantFuture]};
        }
        NSMutableDictionary *mProperties = [properties mutableCopy];
        [mProperties removeObjectForKey:NSHTTPCookieDiscard];
        cookie = [NSHTTPCookie cookieWithProperties:mProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
}


+ (void)updateCookieByName:(NSString *)cookieName withValue:(NSString *)value {
    [self updateCookieByName:cookieName withValue:value domain:nil path:nil expiresDate:nil];
}

+ (void)updateCookieByName:(NSString *)cookieName withValue:(NSString *)value domain:(NSString *)domain path:(NSString *)path expiresDate:(NSDate *)expiresDate {
    if (![StringUtility isStringNotEmptyOrNil:cookieName]) {
        return;
    }
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookiesArray = [storage cookies];
    
    for (NSHTTPCookie *cookie in cookiesArray) {
        NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
        if ([cookie.name isEqualToString:cookieName]) {
            
            [mutableDic setObject:cookieName forKey:NSHTTPCookieName];
            
            [mutableDic setObjectSafe:value?:cookie.value forKey:NSHTTPCookieValue];
            [mutableDic setObjectSafe:expiresDate?:cookie.expiresDate forKey:NSHTTPCookieExpires];
            [mutableDic setObjectSafe:domain?:cookie.domain forKey:NSHTTPCookieDomain];
            [mutableDic setObjectSafe:path?:cookie.path forKey:NSHTTPCookiePath];
            
            NSHTTPCookie *newCookie = [[NSHTTPCookie alloc] initWithProperties:mutableDic];
            
            [storage setCookie:newCookie];
        }
    }
}

+ (void)clearAllCookies {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie* cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}



@end
