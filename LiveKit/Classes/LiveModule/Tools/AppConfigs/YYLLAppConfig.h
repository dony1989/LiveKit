//
//  LiveAppConfig.h
//  PrivateTest
//
//  Created by don on 2021/7/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LiveModuleCategoryHeader.h"
#import "EncyptUtility.h"

NS_ASSUME_NONNULL_BEGIN


 // MARK屏幕尺寸
FOUNDATION_EXPORT CGFloat kYYLLScreenWidth(void);
FOUNDATION_EXPORT CGFloat kYYLLScreenHeight(void);

FOUNDATION_EXPORT BOOL kIsIphoneX_YML(void);
FOUNDATION_EXPORT CGFloat kYYLLStatusBarHeight(void);
FOUNDATION_EXPORT CGFloat kYYLLSafeAreaTop(void);
FOUNDATION_EXPORT CGFloat kYYLLSafeAreaBottom(void);
FOUNDATION_EXPORT CGFloat kYYLLSafeAreaLeft(void);
FOUNDATION_EXPORT CGFloat kYYLLSafeAreaRight(void);
FOUNDATION_EXPORT UIInterfaceOrientation YYLLNowInterfaceOrientation(void);

// MARK: 类型安全检测
FOUNDATION_EXPORT BOOL YYLLIsString(NSString *str);
FOUNDATION_EXPORT BOOL YYLLIsStringNotEmpty(NSString *str);
FOUNDATION_EXPORT NSString *YYLLSafeString(id str);

FOUNDATION_EXPORT BOOL YYLLIsArray(NSArray *array);
FOUNDATION_EXPORT BOOL YYLLIsArrayNotEmpty(NSArray *array);

FOUNDATION_EXPORT BOOL YYLLIsDictionary(NSDictionary *dic);
FOUNDATION_EXPORT BOOL YYLLIsDictionaryNotEmpty(NSDictionary *dic);

// MARK: 系统字体
/// 系统字体，默认Regular。
FOUNDATION_EXPORT UIFont *YYLLSystemFont(CGFloat size);
/// 系统字体粗体。
FOUNDATION_EXPORT UIFont *YYLLSystemFontBold(CGFloat size);
/**
 系统字体。
 @param size 字号。
 @param weight 字体粗细。
 */
FOUNDATION_EXPORT UIFont *YYLLSystemFontWithWeight(CGFloat size, UIFontWeight weight);

// MARK: 系统颜色
/// hex颜色。
FOUNDATION_EXPORT UIColor *YYLLHexColor(long hex);
FOUNDATION_EXPORT UIColor *YYLLHexColorWithAlpha(long hex, CGFloat alpha);

// MARK: GCD 相关封装
FOUNDATION_EXPORT void YYLLQueueAsync(dispatch_queue_t queue, dispatch_block_t block);
FOUNDATION_EXPORT void YYLLMainQueueAsync(dispatch_block_t block);

FOUNDATION_EXPORT dispatch_semaphore_t YYLLSemaCreate(intptr_t value);
FOUNDATION_EXPORT intptr_t YYLLSemaWait(dispatch_semaphore_t sema, dispatch_time_t time);
FOUNDATION_EXPORT intptr_t YYLLSemaSignal(dispatch_semaphore_t sema);

@interface YYLLAppConfig : NSObject

@end

NS_ASSUME_NONNULL_END
