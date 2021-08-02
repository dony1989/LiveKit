//
//  ArrayUtility.m
//  Yuwen
//
//  Created by panyu_lt on 2016/12/11.
//  Copyright © 2016年 yimilan. All rights reserved.
//

#import "ArrayUtility.h"
#import "YYLLAppConfig.h"

@implementation ArrayUtility

+ (BOOL)isArrayNotEmptyOrNil:(NSArray *)array {
    return YYLLIsArrayNotEmpty(array);
}

+ (NSArray *)soreDictionaryArray:(NSArray *)sourceArray withDictionaryKey:(NSString *)key ByAscending:(BOOL)ascending {
    
    NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
    
    NSArray *sortedArray = [sourceArray sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}

@end
