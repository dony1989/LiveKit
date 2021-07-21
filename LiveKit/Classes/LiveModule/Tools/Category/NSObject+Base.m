//
//  NSObject+Base.m
//  PrivateTest
//
//  Created by don on 2021/7/20.
//

#import "NSObject+Base.h"
#import "LiveAppConfig.h"
#import "LiveModuleCategoryHeader.h"

@implementation NSString (URL)

- (NSString * __nullable)scheme {
    if (LiveIsStringNotEmpty(self)) {
        NSURLComponents *components = [[NSURLComponents alloc] initWithString:self];
        if (components) {
            return components.scheme;
        }
    }
    return nil;
}

- (NSString * __nullable)host {
    if (LiveIsStringNotEmpty(self)) {
        NSURLComponents *components = [[NSURLComponents alloc] initWithString:self];
        if (components) {
            return components.host;
        }
    }
    return nil;
}

- (NSString * __nullable)path {
    if (LiveIsStringNotEmpty(self)) {
        NSURLComponents *components = [[NSURLComponents alloc] initWithString:self];
        if (components) {
            return components.path;
        }
    }
    return nil;
}

- (NSString * __nullable)query {
    if (LiveIsStringNotEmpty(self)) {
        NSURLComponents *components = [[NSURLComponents alloc] initWithString:self];
        if (components) {
            return components.query;
        }
    }
    return nil;
}

- (NSDictionary * __nullable)queries {
    if (LiveIsStringNotEmpty(self)) {
        NSURLComponents *components = [[NSURLComponents alloc] initWithString:self];
        if (components) {
            NSArray *items = components.queryItems;
            if (LiveIsArrayNotEmpty(items)) {
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
    if (LiveIsStringNotEmpty(self)) {
        return [self stringByRemovingPercentEncoding];
    }
    return nil;
}

- (NSString * __nullable)kHYURLEncodingString {
    if (LiveIsStringNotEmpty(self)) {
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
