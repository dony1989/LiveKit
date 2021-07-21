//
//  LiveAppConfig.m
//  PrivateTest
//
//  Created by don on 2021/7/21.
//

#import "LiveAppConfig.h"

// MARK: 屏幕尺寸
CGFloat kLiveScreenWidth(void) {
    return [[UIScreen mainScreen] bounds].size.width;
}

CGFloat kLiveScreenHeight(void) {
    return [[UIScreen mainScreen] bounds].size.height;
}

CGFloat kLiveStatusBarHeight(void) {
    CGFloat statusBarHeight = 20;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }
    else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    statusBarHeight = MAX(statusBarHeight, 20);
    return MAX(statusBarHeight, kLiveSafeAreaTop());
}

CGFloat kLiveSafeAreaTop(void) {
    if (@available(iOS 11, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
    }
    return 0;
}
CGFloat kLiveSafeAreaBottom(void) {
    if (@available(iOS 11, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    return 0;
}

CGFloat kLiveSafeAreaLeft(void) {
    if (@available(iOS 11, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.left;
    }
    return 0;
}
CGFloat kLiveSafeAreaRight(void) {
    if (@available(iOS 11, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.right;
    }
    return 0;
}

BOOL kIsIphoneX_YML(void) {
    BOOL isPhoneX = NO;
    if (@available(iOS 11.0, *)) {
        isPhoneX = kLiveSafeAreaBottom() > 0.0 || kLiveSafeAreaLeft() > 0.0;
    }
    return isPhoneX;
}

UIInterfaceOrientation HYNowInterfaceOrientation(void) {
    return [[UIApplication sharedApplication] statusBarOrientation];
}

// MARK: 类型安全检测
NSString *LiveSafeString(id str) {
    if (str) {
        if ([str isKindOfClass:[NSString class]]) {
            if ([(NSString *)str isEqualToString:@"<null>"]) {
                return @"";
            } else if ([(NSString *)str isEqualToString:@"null"]) {
                return @"";
            } else if ([(NSString *)str isEqualToString:@"(null)"]) {
                return @"";
            } else {
                return [NSString stringWithFormat:@"%@",str];
            }
        }
        if ([str isKindOfClass:[NSValue class]] || [str isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@", str];
        }
    }
    return @"";
}

BOOL LiveIsString(NSString *str) {
    if (str && [str isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

BOOL LiveIsStringNotEmpty(NSString *str) {
    if (str && [str isKindOfClass:[NSString class]]) {
        return [(NSString *)str length] > 0;
    }
    return NO;
}

BOOL LiveIsArray(NSArray *array) {
    if (array && [array isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}

BOOL LiveIsArrayNotEmpty(NSArray *array) {
    if (array && [array isKindOfClass:[NSArray class]]) {
        return [(NSArray *)array count] > 0;
    }
    return NO;
}

BOOL LiveIsDictionary(NSDictionary *dic) {
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}

BOOL LiveIsDictionaryNotEmpty(NSDictionary *dic) {
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)dic count] > 0;
    }
    return NO;
}

// MARK: 系统字体
UIFont *LiveSystemFont(CGFloat size) {
    return [UIFont systemFontOfSize:size];
}

UIFont *LiveSystemFontBold(CGFloat size) {
    return [UIFont boldSystemFontOfSize:size];
}

UIFont *HYSystemFontWithWeight(CGFloat size, UIFontWeight weight) {
    return [UIFont systemFontOfSize:size weight:weight];
}

// MARK: 颜色
UIColor *LiveHexColor(long hex) {
    return [UIColor colorWithRed:((hex>>16)&0xFF)/255.0 green:((hex>>8)&0xFF)/255.0 blue:(hex&0xFF)/255.0 alpha:1.0];
}

UIColor *LiveHexColorWithAlpha(long hex, CGFloat alpha) {
    return [UIColor colorWithRed:((hex>>16)&0xFF)/255.0 green:((hex>>8)&0xFF)/255.0 blue:(hex&0xFF)/255.0 alpha:alpha];
}

@implementation LiveAppConfig

@end
