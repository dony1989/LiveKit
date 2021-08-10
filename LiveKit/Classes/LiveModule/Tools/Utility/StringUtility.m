//
//  StringUtility.m
//  Yuwen
//
//  Created by panyu_lt on 2016/12/9.
//  Copyright © 2016年 yimilan. All rights reserved.
//

#import "StringUtility.h"
//#import "NSString+SafeCategory.h"
#import "LiveModuleHeader.h"

@implementation StringUtility

+ (BOOL)isStringNotEmptyOrNil:(NSString *)string {
    if (string == nil || ![string isKindOfClass:[NSString class]]) {
        return NO;
    }
    return string.length > 0 ;
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing
{
    return [self attributedStringWithString:string font:font color:color lineSpacing:lineSpacing textAlignment:NSTextAlignmentLeft];
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing textAlignment:(NSTextAlignment)textAlignment
{
    return [self attributedStringWithString:string font:font color:color lineSpacing:lineSpacing textAlignment:textAlignment lineBreakMode:NSLineBreakByTruncatingTail];
    
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                              font:(UIFont *)font
                                             color:(UIColor *)color
                                       lineSpacing:(CGFloat)lineSpacing
                                     textAlignment:(NSTextAlignment)textAlignment
                                     lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if (![self isStringNotEmptyOrNil:string]) {
        return nil;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpacing;
    paraStyle.alignment = textAlignment;
    paraStyle.lineBreakMode = lineBreakMode;
    
    NSDictionary *att = @{NSForegroundColorAttributeName:color,NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle};
    return [[NSAttributedString alloc] initWithString:string attributes:att];
}



+ (NSMutableAttributedString *)createAttribute:(NSString *)content contentFont:(UIFont *)font color:(UIColor *)color isAlignmentCenter:(BOOL)center{
    
    if ([self isStringNotEmptyOrNil:content]) {
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 5;
        if (center) {
            style.alignment = NSTextAlignmentCenter;
        }
        [attribute addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,content.length)];
        return attribute;
    }
    return nil;
}

+ (NSMutableAttributedString *)createAttribute:(NSString *)content contentFont:(UIFont *)font isAlignmentCenter:(BOOL)center{
    
    if ([self isStringNotEmptyOrNil:content]) {
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:font}];

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 5;
        if (center) {
            style.alignment = NSTextAlignmentCenter;
        }
        [attribute addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,content.length)];
        return attribute;
    }
    return nil;
}


+ (CGFloat)layoutAttributeHeight:(NSMutableAttributedString *)attribute contentFont:(UIFont *)font limitSize:(CGSize)limitSize{
    CGRect bounds = [attribute boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading context:nil];
    return bounds.size.height;
}

+ (NSMutableAttributedString *)createHtmlAttribute:(NSString *)content contentFont:(UIFont *)font{
    
    if ([self isStringNotEmptyOrNil:content]) {
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSRange range = [attribute.string rangeOfString:@"\n"];
        if (range.length > 0) {
            [attribute deleteCharactersInRange:range];
        }
        if (font) {
            [attribute addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attribute.length)];
//            [attribute addAttributeFont:font range:NSMakeRange(0, attribute.length)];
        }
        return attribute;
    }
    return nil;
}

// TODO:lt 换个方法来计算文本高度，，不能阻塞主线程
static UILabel *helperHeightLabel = nil;
static UILabel *helperWidthLabel = nil;
static UILabel *helperHeightNumberLineLabel = nil;



+ (CGFloat)layoutContentWidth:(NSString *)content contentFont:(UIFont *)font limitSize:(CGSize)limitSize{
    
    CGFloat width = [content boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width;
    
    return width;
}

+ (CGFloat)heightForAttString:(NSAttributedString *)attString width:(CGFloat)width
{
    CGFloat height = 0;
    if (attString && [attString isKindOfClass:NSAttributedString.class]) {
        
        height = [attString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                         context:nil].size.height;
    }
    
    return height;
}

+ (NSString *)checkString:(NSString *)oriString
{
    if (![self isStringNotEmptyOrNil:oriString]) {
        return @"";
    }
    return oriString;
}

+ (BOOL)checkIsOnlyContainSpace:(NSString *)string
{
    if (!string || ![string isKindOfClass:NSString.class]) {
        return YES;
    }
    return [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0;
}

/**
 *    处理null字符串
 */
+ (NSString*)stringWithEmptyOrNil:(NSObject *)obj {
    
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return @"";
        
    }else if ([obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",obj];
    }else if(![obj isKindOfClass:[NSString class]]) {
        return @"";
    }else if ([obj isKindOfClass:[NSString class]]) {
        if ([(NSString *)obj isEqualToString:@"<null>"]) {
            return @"";
        }else if ([(NSString *)obj isEqualToString:@"null"]) {
            return @"";
        }else if ([(NSString *)obj isEqualToString:@"(null)"]) {
            return @"";
        }else {
            return [NSString stringWithFormat:@"%@",obj];
        }
    }else {
        return @"";
    }
}



///数字转汉字
+(NSString *)intToTring:(NSInteger)num {
    switch (num) {
        case 0:
            return @"零";
            break;
        case 1:
            return @"一";
            break;
        case 2:
            return @"二";
            break;
        case 3:
            return @"三";
            break;
        case 4:
            return @"四";
            break;
        case 5:
            return @"五";
            break;
        case 6:
            return @"六";
            break;
            
        default:
            return @"";
            break;
    }
}




// ios 11之后从电话簿复制粘贴会出现特殊不可见字符 需要处理
+ (NSString *)getSeparatedPhoneNumberWithString:(NSString *)phoneString {
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSString *string = phoneString; //invertedSet方法是去反字符,把所有的除了characterSet里的字符都找出来(包含去空格功能)
    NSCharacterSet *specCharacterSet = [characterSet invertedSet];
    NSArray *strArr = [string componentsSeparatedByCharactersInSet:specCharacterSet];
    return [strArr componentsJoinedByString:@""];
}


/// 电话号码分割
+ (NSString *)filterTelNo:(NSString *)telNo {
    if ([StringUtility isStringNotEmptyOrNil:telNo]) {
        telNo = [telNo stringByReplacingOccurrencesOfString:@"  " withString:@""];
        
        telNo = [telNo stringByReplacingOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, telNo.length)];
    }
    return telNo;
}
+ (void)setTextField:(UITextField *)textField withTelNo:(NSString *)finalString {
    NSInteger length = finalString.length;
    NSString *spaceString = @"  ";
    NSMutableString *seperateString = [NSMutableString string];
    NSString *leftString = @"";
    NSString *preString = finalString;
    
    if (length>3) {
        preString = [finalString substringToIndex:3];
        leftString = [finalString substringFromIndex:3];
    }
    [seperateString appendString:preString];
    
    if (leftString.length > 4) {
        NSString *midString = [leftString substringToIndex:4];
        [seperateString appendString:spaceString];
        [seperateString appendString:midString];
        leftString = [leftString substringFromIndex:4];
    }
    
    if (leftString.length > 0) {
        [seperateString appendString:spaceString];
        [seperateString appendString:leftString];
    }
    
    NSInteger maxLength = 11+spaceString.length*2;
    if (seperateString.length > maxLength) {
        seperateString = (NSMutableString *)[seperateString substringToIndex:maxLength];
    }
    
    textField.text = seperateString;
}

+ (BOOL)checkOnlyContainChineseOrLetterInString:(NSString *)string {
    NSString *regex = @"^[\u4e00-\u9fa5a-zA-Z-z]+";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [pred evaluateWithObject:string];
}

+ (BOOL)checkOnlyContainChineseInString:(NSString *)string
{
    NSString *regex = @"[\u4e00-\u9fa5]+";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [pred evaluateWithObject:string];
    
}

+ (BOOL)checkOnlyContainNoAndLetterInString:(NSString *)string
{
    NSString *regex = @"([0-9]{17}([0-9]|X|x)$)";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [pred evaluateWithObject:string];

}

+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

/**
 基础方法
 
 @param regex 正则表达式
 @return 正则验证成功返回YES, 否则返回NO
 */
+ (BOOL)isValidateByRegex:(NSString *)regex mobileNumber:(NSString *)mobileNum {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:mobileNum];
}
/**
 验证手机号码
 
 @return 正则验证成功返回YES, 否则返回NO
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    // @"^(13[0-9]|14[56789]|15[0-9]|16[6]|17[0-9]|18[0-9]|19[89])\\d{8}$";
    // 先都写上，防止之后有变化
    NSString *mobileRegex = @"^(1)\\d{10}$";
//    NSString *mobileRegex = @"^1[345789]\\d{9}$";
    return [self isValidateByRegex:mobileRegex mobileNumber:mobileNum];
}
/**
 密码规则 6~12位的字母或数字；（不可含有特殊字符及空格，区分大小写）
 */
+ (BOOL)validatePassword:(NSString *)password {
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,12}$";
    return [self isValidateByRegex:regex mobileNumber:password];
}
/**
 根据字典生成字符串
 */
+ (NSMutableString *)jsonStringWithDictionary:(NSMutableDictionary *)jsonDictionary{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    //去掉字符串中的空格
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    //去掉字符串中的换行符
     NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    //去掉字符串中的转义字符
    NSMutableString *responseString = [NSMutableString stringWithString:mutStr];
    NSString *character = nil;
    for (int i = 0; i < responseString.length; i ++) {
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
    }

    NSLog(@"jsonString---------%@",responseString);
    
    return responseString;
}

+ (NSMutableString *)jsonStringWithDictionaryWithoutFilter:(NSMutableDictionary *)jsonDictionary{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    //去掉字符串中的空格
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    //去掉字符串中的换行符
     NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}

+ (NSMutableDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (![self isStringNotEmptyOrNil:jsonString]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return [dic mutableCopy];
}

+ (NSMutableString *)jsonStringWithArray:(NSMutableArray *)jsonArray{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    //去掉字符串中的空格
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    //去掉字符串中的换行符
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    //去掉字符串中的转义字符
    NSMutableString *responseString = [NSMutableString stringWithString:mutStr];
    NSString *character = nil;
    for (int i = 0; i < responseString.length; i ++) {
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
    }
    
    NSLog(@"jsonString---------%@",responseString);
    
    return responseString;
}

+ (NSMutableArray *)arrayWithJsonString:(NSString *)jsonString{
    
    if (![self isStringNotEmptyOrNil:jsonString]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return [array mutableCopy];
}

+ (NSString *)timeStringWithDuration:(CGFloat)duration
{
    int minute = duration / 60;
    int second = (int)duration % 60;
    NSString *time = [NSString stringWithFormat:@"%02d:%02d",minute,second];
    return time;
}

#pragma mark 输入中文
+ (BOOL)deptNameInputShouldChinese:(NSString *)string {
    
    int stringLength = (int)[StringUtility stringWithEmptyOrNil:string].length;

    for (int i = 0; i < stringLength; i++) {
    
        NSString *subString = [string substringWithRangeSafe:NSMakeRange(i, 1)];
    
        NSString *regex = @"[\u4e00-\u9fa5]+";

        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
        if (![pred evaluateWithObject:subString]) {
            return NO;
        }
    }
        
    return YES;
    
}


#pragma mark 判断全数字：
+ (BOOL)deptNumInputShouldNumber:(NSString *)string {
    
    int stringLength = (int)[StringUtility stringWithEmptyOrNil:string].length;

    for (int i = 0; i < stringLength; i++) {
        
        NSString *subString = [string substringWithRangeSafe:NSMakeRange(i, 1)];
        
        NSString *regex =@"[0-9]*";

        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if (![pred evaluateWithObject:subString]) {
            return NO;
        }
        
    }
    
    return YES;
    
}

#pragma mark 判断全字母：
+ (BOOL)deptPassInputShouldAlpha:(NSString *)string {
    
    
    int stringLength = (int)[StringUtility stringWithEmptyOrNil:string].length;

    for (int i = 0; i < stringLength; i++) {
        
        NSString *subString = [string substringWithRangeSafe:NSMakeRange(i, 1)];
        
        NSString *regex =@"[a-zA-Z]*";
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if (![pred evaluateWithObject:subString]) {
            return NO;
        }
        
    }
    
    return YES;
    
}


/// 判断字符串中是否是中文 字母
+ (BOOL)deptNameInputShouldChineseOrAlpha:(NSString *)string {
    
    int stringLength = (int)[StringUtility stringWithEmptyOrNil:string].length;
    
    for (int i = 0; i < stringLength; i++) {

        NSString *subString = [string substringWithRangeSafe:NSMakeRange(i, 1)];
        
        /// 兼容系统键盘
        BOOL shouldChange = [StringUtility deptNameInputShouldChinese:subString] || [StringUtility deptPassInputShouldAlpha:subString] || [@"➋➌➏➎➍➐➑➒" containsString:subString];
        if (!shouldChange) {
            return NO;
        }
        
    }
    
    return YES;
}

/// 判断字符串中是否是中文 字母 或者 数字
+ (BOOL)deptNameInputShouldChineseOrNumberOrAlpha:(NSString *)string {
    
    int stringLength = (int)[StringUtility stringWithEmptyOrNil:string].length;
    
    for (int i = 0; i < stringLength; i++) {

        NSString *subString = [string substringWithRangeSafe:NSMakeRange(i, 1)];
        
        /// 兼容系统键盘
        BOOL shouldChange = [StringUtility deptNameInputShouldChinese:subString] || [StringUtility deptNumInputShouldNumber:subString] || [StringUtility deptPassInputShouldAlpha:subString] || [@"➋➌➏➎➍➐➑➒" containsString:subString];
        if (!shouldChange) {
            return NO;
        }
        
    }
    
    return YES;
}


/// 限制文本框最大长度
+ (BOOL)hy_subToStringLength:(int)kMaxLength textFiled:(UITextField *)textField {

    NSString *toBeString = textField.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:kMaxLength];
                if (rangeIndex.length == 1) {
                    textField.text = [toBeString substringToIndex:kMaxLength];
                }else {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, kMaxLength)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
                return YES;
            }
        }
    }else {
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:kMaxLength];
            if (rangeIndex.length == 1) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0,kMaxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
            return YES;
        }
    }
    return NO;
}

/// 限制textView文本框最大长度
+ (BOOL)hy_subToStringLength:(int)kMaxLength textView:(UITextView *)textView {

    NSString *toBeString = textView.text;
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage; // 键盘输入模
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:kMaxLength];
                if (rangeIndex.length == 1) {
                    textView.text = [toBeString substringToIndex:kMaxLength];
                }else {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, kMaxLength)];
                    textView.text = [toBeString substringWithRange:rangeRange];
                }
                return YES;
            }
        }
    }else {
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:kMaxLength];
            if (rangeIndex.length == 1) {
                textView.text = [toBeString substringToIndex:kMaxLength];
            }else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0,kMaxLength)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
            return YES;
        }
    }
    return NO;
}

/// 文本框只允许输入中文
+ (UITextRange *)hy_onlyInputChineseWithTextFiled:(UITextField *)textField {
    
    
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    if (!position) { // 没有高亮选择的字
        //过滤非汉字字符
        textField.text = [self filterCharactor:textField.text withRegex:@"[^\u4e00-\u9fa5]"];
         
    }else { //有高亮文字
        //do nothing
    }
    
    return selectedRange;
    
}


/// 文本框只允许输入中文 数字
+ (UITextRange *)hy_onlyInputChineseOrNumberWithTextFiled:(UITextField *)textField {
    
    
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    if (!position) { // 没有高亮选择的字
        //过滤非汉字字符
        textField.text = [self filterCharactor:textField.text withRegex:@"[^0-9\u4e00-\u9fa5]"];
         
    }else { //有高亮文字
        //do nothing
    }
    
    return selectedRange;
    
}


/// 根据正则，过滤特殊字符
+ (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}


@end


