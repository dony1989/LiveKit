//
//  LiveAppConfig.h
//  PrivateTest
//
//  Created by don on 2021/7/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


 // MARK屏幕尺寸
FOUNDATION_EXPORT CGFloat kLiveScreenWidth(void);
FOUNDATION_EXPORT CGFloat kLiveScreenHeight(void);

FOUNDATION_EXPORT BOOL kIsIphoneX_YML(void);
FOUNDATION_EXPORT CGFloat kLiveStatusBarHeight(void);
FOUNDATION_EXPORT CGFloat kLiveSafeAreaTop(void);
FOUNDATION_EXPORT CGFloat kLiveSafeAreaBottom(void);
FOUNDATION_EXPORT CGFloat kLiveSafeAreaLeft(void);
FOUNDATION_EXPORT CGFloat kLiveSafeAreaRight(void);
FOUNDATION_EXPORT UIInterfaceOrientation LiveNowInterfaceOrientation(void);

// MARK: 类型安全检测
FOUNDATION_EXPORT BOOL LiveIsString(NSString *str);
FOUNDATION_EXPORT BOOL LiveIsStringNotEmpty(NSString *str);
FOUNDATION_EXPORT NSString *LiveSafeString(id str);

FOUNDATION_EXPORT BOOL LiveIsArray(NSArray *array);
FOUNDATION_EXPORT BOOL LiveIsArrayNotEmpty(NSArray *array);

FOUNDATION_EXPORT BOOL LiveIsDictionary(NSDictionary *dic);
FOUNDATION_EXPORT BOOL LiveIsDictionaryNotEmpty(NSDictionary *dic);

// MARK: 系统字体
/// 系统字体，默认Regular。
FOUNDATION_EXPORT UIFont *LiveSystemFont(CGFloat size);
/// 系统字体粗体。
FOUNDATION_EXPORT UIFont *LiveSystemFontBold(CGFloat size);
/**
 系统字体。
 @param size 字号。
 @param weight 字体粗细。
 */
FOUNDATION_EXPORT UIFont *LiveSystemFontWithWeight(CGFloat size, UIFontWeight weight);

// MARK: 系统颜色
/// hex颜色。
FOUNDATION_EXPORT UIColor *LiveHexColor(long hex);
FOUNDATION_EXPORT UIColor *LiveHexColorWithAlpha(long hex, CGFloat alpha);



@interface LiveAppConfig : NSObject

@end

NS_ASSUME_NONNULL_END
