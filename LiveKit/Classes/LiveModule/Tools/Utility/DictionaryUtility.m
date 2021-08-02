//
//  DictionaryUtility.m
//  YiMiSchool
//
//  Created by 吴凯强 on 2021/1/8.
//  Copyright © 2021 yimilan. All rights reserved.
//

#import "DictionaryUtility.h"
#import "YYLLAppConfig.h"

@implementation DictionaryUtility


+ (BOOL)isDictionaryNotEmptyOrNil:(NSDictionary *)dic {
    return YYLLIsDictionaryNotEmpty(dic);
}

/*
 a=1&b=2。。。
 */
+ (NSDictionary *)transformString:(NSString *)oriString useConnectString:(NSString *)conString {
    NSDictionary *dic = @{};
    if (!oriString || ![oriString isKindOfClass:[NSString class]]) {
        return dic;
    }
    
    NSArray *items = @[];
    NSRange conStringRange = [oriString rangeOfString:conString];
    if (conStringRange.location != NSNotFound) { // 多个参数
        items = [oriString componentsSeparatedByString:conString];
    }
    else
    {
        items = @[oriString];
    }
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    NSString *eqSrting = @"=";
    for (NSString *subString in items) {
        
        NSRange range = [subString rangeOfString:eqSrting];
        if (range.location != NSNotFound ) {
            
            NSArray *tempArray = [subString componentsSeparatedByString:eqSrting];
            if (tempArray && tempArray.count > 1) {
                [tempDic setObject:tempArray[1] forKey:tempArray[0]];
            }
        }
    }
    
    return tempDic;
    
}

@end
