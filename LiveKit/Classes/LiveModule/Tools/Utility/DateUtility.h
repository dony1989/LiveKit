//
//  DateUtility.h
//  Yuwen
//
//  Created by panyu_lt on 2017/9/6.
//  Copyright © 2017年 yimilan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtility : NSObject

// 约定默认使用时间日期字符串格式为  yyyy-MM-dd HH:mm:ss

+ (NSDate *)dateFromString:(NSString *)date;
+ (NSDate *)dateFromString:(NSString *)date withFormatter:(NSString *)format;

+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date withFormatter:(NSString *)format;

+ (NSTimeInterval)timeIntervalSinceNow:(NSString *)dateString;
+ (NSTimeInterval)timeIntervalFrom:(NSString *)startDate to:(NSString *)endDate;

+ (NSComparisonResult)compareDateA:(NSDate *)dateA withDateB:(NSDate *)dateB;

+ (BOOL)isSameDayBetween:(NSString *)dateAString and:(NSString *)dateBString;
+ (BOOL)isSameDayCompare:(NSDate *)dateA with:(NSDate *)dateB;

+ (NSString *)timeStringWithTimeCount:(int)timeCount hour:(BOOL)hour min:(BOOL)min sec:(BOOL)sec;
+ (NSString *)getTimeCount:(int)timeCount sufixString:(NSString *)sufixString;

+ (NSArray *)getMonthFirstAndLastDayWith:(NSString *)dateStr;

//计算两个日期字符串的差值
+ (NSTimeInterval)getTotalTimeWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

//计算两个日期字符串的差值, 并格式化
+ (NSString *)getTotalFormmatTimeWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
// 得到月日时分字符串
+ (NSString *)getMonthDayTimeStringWithDateString:(NSString *)dateString;

+ (BOOL)isSameYearWithDate:(NSDate *)date;

@end
