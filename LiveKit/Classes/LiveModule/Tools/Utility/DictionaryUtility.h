//
//  DictionaryUtility.h
//  YiMiSchool
//
//  Created by 吴凯强 on 2021/1/8.
//  Copyright © 2021 yimilan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DictionaryUtility : NSObject

+ (BOOL)isDictionaryNotEmptyOrNil:(NSDictionary *)dic;

/*
 a=1&b=2。。。
 */
+ (NSDictionary *)transformString:(NSString *)oriString useConnectString:(NSString *)conString;

@end

NS_ASSUME_NONNULL_END
