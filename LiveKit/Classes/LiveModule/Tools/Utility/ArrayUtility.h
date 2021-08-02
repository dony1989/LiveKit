//
//  ArrayUtility.h
//  Yuwen
//
//  Created by panyu_lt on 2016/12/11.
//  Copyright © 2016年 yimilan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayUtility : NSObject

+ (BOOL)isArrayNotEmptyOrNil:(NSArray *)array;

/**
 排序 数组<字典#>
 @param sourceArray 要排序的数组
 @param key         排序的key
 @param ascending   是否升序
 */
+ (NSArray *)soreDictionaryArray:(NSArray *)sourceArray withDictionaryKey:(NSString *)key ByAscending:(BOOL)ascending;

@end
