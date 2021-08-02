//
//  NSObject+Base.m
//  PrivateTest
//
//  Created by don on 2021/7/20.
//

#import "NSObject+Base.h"
#import "YYLLAppConfig.h"
#import "LiveModuleCategoryHeader.h"

@implementation NSString (URL)

- (NSString * __nullable)scheme {
    if (YYLLIsStringNotEmpty(self)) {
        NSURLComponents *components = [[NSURLComponents alloc] initWithString:self];
        if (components) {
            return components.scheme;
        }
    }
    return nil;
}

- (NSString * __nullable)host {
    if (YYLLIsStringNotEmpty(self)) {
        NSURLComponents *components = [[NSURLComponents alloc] initWithString:self];
        if (components) {
            return components.host;
        }
    }
    return nil;
}

- (NSString * __nullable)path {
    if (YYLLIsStringNotEmpty(self)) {
        NSURLComponents *components = [[NSURLComponents alloc] initWithString:self];
        if (components) {
            return components.path;
        }
    }
    return nil;
}

- (NSString * __nullable)query {
    if (YYLLIsStringNotEmpty(self)) {
        NSURLComponents *components = [[NSURLComponents alloc] initWithString:self];
        if (components) {
            return components.query;
        }
    }
    return nil;
}

- (NSDictionary * __nullable)queries {
    if (YYLLIsStringNotEmpty(self)) {
        NSURLComponents *components = [[NSURLComponents alloc] initWithString:self];
        if (components) {
            NSArray *items = components.queryItems;
            if (YYLLIsArrayNotEmpty(items)) {
                NSMutableDictionary *queries = [NSMutableDictionary dictionary];
                for (NSURLQueryItem *item in items) {
                    [queries setObjectSafe:item.value forKey:item.name];
                }
                return [queries copy];
            }
        }
    }
    return nil;
}

- (NSString * __nullable)kHYURLDecodingString {
    if (YYLLIsStringNotEmpty(self)) {
        return [self stringByRemovingPercentEncoding];
    }
    return nil;
}

- (NSString * __nullable)kHYURLEncodingString {
    if (YYLLIsStringNotEmpty(self)) {
        NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        NSString *encodedUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        return encodedUrl;
    }
    return nil;
}

@end


@implementation NSError (Ext)
-(NSString *)errorInfo
{
    NSString *result = [self.userInfo valueForKey:@"NSLocalizedDescription"];
    return result?result:self.domain;
}
@end
