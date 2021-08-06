//
//  StringUtility.h
//  Yuwen
//
//  Created by panyu_lt on 2016/12/9.
//  Copyright © 2016年 yimilan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface StringUtility : NSObject

/// 判断字符串是否为空
+ (BOOL)isStringNotEmptyOrNil:(NSString *)string;
/**
 字符串类型判断
 */
+ (NSString*)stringWithEmptyOrNil:(NSObject *)obj;



+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                              font:(UIFont *)font
                                             color:(UIColor *)color
                                       lineSpacing:(CGFloat)lineSpacing;

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                              font:(UIFont *)font
                                             color:(UIColor *)color
                                       lineSpacing:(CGFloat)lineSpacing
                                     textAlignment:(NSTextAlignment)textAlignment;

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                              font:(UIFont *)font
                                             color:(UIColor *)color
                                       lineSpacing:(CGFloat)lineSpacing
                                     textAlignment:(NSTextAlignment)textAlignment
                                     lineBreakMode:(NSLineBreakMode)lineBreakMode;

+ (NSMutableAttributedString *)createAttribute:(NSString *)content contentFont:(UIFont *)font color:(UIColor *)color isAlignmentCenter:(BOOL)center;
+ (NSMutableAttributedString *)createAttribute:(NSString *)content contentFont:(UIFont *)font isAlignmentCenter:(BOOL)center;
+ (NSMutableAttributedString *)createHtmlAttribute:(NSString *)content contentFont:(UIFont *)font;
// ios 11之后从电话簿复制粘贴会出现特殊不可见字符 需要处理
+ (NSString *)getSeparatedPhoneNumberWithString:(NSString *)phoneString;
/// 电话号码分割
+ (NSString *)filterTelNo:(NSString *)telNo;

+ (void)setTextField:(UITextField *)textField withTelNo:(NSString *)finalString;

+ (CGFloat)layoutContentAttributeHeight:(NSString *)content contentFont:(UIFont *)font limitSize:(CGSize)limitSize;

+ (CGFloat)layoutAttributeHeight:(NSMutableAttributedString *)attribute contentFont:(UIFont *)font limitSize:(CGSize)limitSize;

+ (CGFloat)layoutContenHtmltHeight:(NSString *)content contentFont:(UIFont *)font limitSize:(CGSize)limitSize;

+ (CGFloat)layoutContentWidth:(NSString *)content contentFont:(UIFont *)font limitSize:(CGSize)limitSize;

+ (CGFloat)heightForAttString:(NSAttributedString *)attString width:(CGFloat)width;

/**
 检验字符串是否为nil或者为null等，如果是nil，会返回@""，空字符串,
 如果字符串有值，则返回原字符串
 */
+ (NSString *)checkString:(NSString *)oriString;


/**
 检查是否只包含空格
 */
+ (BOOL)checkIsOnlyContainSpace:(NSString *)string;


// 只包含汉字和字母
+ (BOOL)checkOnlyContainChineseOrLetterInString:(NSString *)string;
// 只包含汉字
+ (BOOL)checkOnlyContainChineseInString:(NSString *)string;

+ (BOOL)checkOnlyContainNoAndLetterInString:(NSString *)string;


// 检查字符串中只有数字
+ (BOOL)validateNumber:(NSString*)number;

/**
 验证手机号码
 
 @return 正则验证成功返回YES, 否则返回NO
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
/**
 验证密码
 
 @return 正则验证成功返回YES, 否则返回NO
 */
+ (BOOL)validatePassword:(NSString *)password;

/**
 根据字典生成字符串
 */
+ (NSMutableString *)jsonStringWithDictionary:(NSMutableDictionary *)jsonDictionary;
/**
 json字典转成json字符串
 @param jsonDictionary json字典
 取消掉了过滤换行符的判断
 @return json字符串
 */
+ (NSMutableString *)jsonStringWithDictionaryWithoutFilter:(NSMutableDictionary *)jsonDictionary;
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSMutableDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 json数组转成json字符串
 @param jsonArray json数组
 @return json字符串
 */
+ (NSMutableString *)jsonStringWithArray:(NSMutableArray *)jsonArray;

+ (NSMutableArray *)arrayWithJsonString:(NSString *)jsonString;

//根据时间段返回时间格式
+ (NSString *)timeStringWithDuration:(CGFloat)duration;

#pragma mark 输入中文
+ (BOOL)deptNameInputShouldChinese:(NSString *)string;
#pragma mark 判断全数字：
+ (BOOL)deptNumInputShouldNumber:(NSString *)string;
#pragma mark 判断全字母：
+ (BOOL)deptPassInputShouldAlpha:(NSString *)string;
/// 判断字符串中是否是中文 字母
+ (BOOL)deptNameInputShouldChineseOrAlpha:(NSString *)string;
/// 判断字符串中是否是中文 字母 或者 数字
+ (BOOL)deptNameInputShouldChineseOrNumberOrAlpha:(NSString *)string;
/// 限制文本框最大长度
+ (BOOL)hy_subToStringLength:(int)kMaxLength textFiled:(UITextField *)textField;
/// 限制textVieW文本框最大长度
+ (BOOL)hy_subToStringLength:(int)kMaxLength textView:(UITextView *)textView;

/// 文本框只允许输入中文
+ (UITextRange *)hy_onlyInputChineseWithTextFiled:(UITextField *)textField;
/// 文本框只允许输入中文 数字
+ (UITextRange *)hy_onlyInputChineseOrNumberWithTextFiled:(UITextField *)textField;
@end


