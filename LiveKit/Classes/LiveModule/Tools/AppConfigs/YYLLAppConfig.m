//
//  LiveAppConfig.m
//  PrivateTest
//
//  Created by don on 2021/7/21.
//

#import "YYLLAppConfig.h"

// MARK: 屏幕尺寸
CGFloat kYYLLScreenWidth(void) {
    return [[UIScreen mainScreen] bounds].size.width;
}

CGFloat kYYLLScreenHeight(void) {
    return [[UIScreen mainScreen] bounds].size.height;
}

CGFloat kYYLLStatusBarHeight(void) {
    CGFloat statusBarHeight = 20;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }
    else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    statusBarHeight = MAX(statusBarHeight, 20);
    return MAX(statusBarHeight, kYYLLSafeAreaTop());
}

CGFloat kYYLLSafeAreaTop(void) {
    if (@available(iOS 11, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
    }
    return 0;
}
CGFloat kYYLLSafeAreaBottom(void) {
    if (@available(iOS 11, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    return 0;
}

CGFloat kYYLLSafeAreaLeft(void) {
    if (@available(iOS 11, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.left;
    }
    return 0;
}
CGFloat kYYLLSafeAreaRight(void) {
    if (@available(iOS 11, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.right;
    }
    return 0;
}

BOOL kIsIphoneX_YML(void) {
    BOOL isPhoneX = NO;
    if (@available(iOS 11.0, *)) {
        isPhoneX = kYYLLSafeAreaBottom() > 0.0 || kYYLLSafeAreaLeft() > 0.0;
    }
    return isPhoneX;
}

UIInterfaceOrientation YYLLNowInterfaceOrientation(void) {
    return [[UIApplication sharedApplication] statusBarOrientation];
}

// MARK: 类型安全检测
NSString *YYLLSafeString(id str) {
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

BOOL YYLLIsString(NSString *str) {
    if (str && [str isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

BOOL YYLLIsStringNotEmpty(NSString *str) {
    if (str && [str isKindOfClass:[NSString class]]) {
        return [(NSString *)str length] > 0;
    }
    return NO;
}

BOOL YYLLIsArray(NSArray *array) {
    if (array && [array isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}

BOOL YYLLIsArrayNotEmpty(NSArray *array) {
    if (array && [array isKindOfClass:[NSArray class]]) {
        return [(NSArray *)array count] > 0;
    }
    return NO;
}

BOOL YYLLIsDictionary(NSDictionary *dic) {
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}

BOOL YYLLIsDictionaryNotEmpty(NSDictionary *dic) {
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)dic count] > 0;
    }
    return NO;
}

// MARK: 系统字体
UIFont *YYLLSystemFont(CGFloat size) {
    return [UIFont systemFontOfSize:size];
}

UIFont *YYLLSystemFontBold(CGFloat size) {
    return [UIFont boldSystemFontOfSize:size];
}

UIFont *YYLLSystemFontWithWeight(CGFloat size, UIFontWeight weight) {
    return [UIFont systemFontOfSize:size weight:weight];
}

// MARK: 颜色
UIColor *YYLLHexColor(long hex) {
    return [UIColor colorWithRed:((hex>>16)&0xFF)/255.0 green:((hex>>8)&0xFF)/255.0 blue:(hex&0xFF)/255.0 alpha:1.0];
}

UIColor *YYLLHexColorWithAlpha(long hex, CGFloat alpha) {
    return [UIColor colorWithRed:((hex>>16)&0xFF)/255.0 green:((hex>>8)&0xFF)/255.0 blue:(hex&0xFF)/255.0 alpha:alpha];
}


// MARK: GCD封装
void YYLLQueueAsync(dispatch_queue_t queue, dispatch_block_t block) {
    dispatch_async(queue, block);
}

void YYLLMainQueueAsync(dispatch_block_t block) {
    YYLLQueueAsync(dispatch_get_main_queue(), block);
}

dispatch_semaphore_t YYLLSemaCreate(intptr_t value) {
    return dispatch_semaphore_create(value);
}
intptr_t YYLLSemaWait(dispatch_semaphore_t sema, dispatch_time_t time) {
    return dispatch_semaphore_wait(sema, time);
}
intptr_t YYLLSemaSignal(dispatch_semaphore_t sema) {
    return dispatch_semaphore_signal(sema);
}

@implementation YYLLAppConfig

@end
