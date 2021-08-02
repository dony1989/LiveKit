//
//  NSDate+Extention.h
//  YunXiao
//
//  Created by wbitos on 14-10-18.
//  Copyright (c) 2014年 YunXiao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNumberOfDaysInWeek 7

@interface NSDate (Extention)
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
- (NSInteger)nanosecond NS_AVAILABLE(10_7, 5_0);
- (NSInteger)weekday;

- (NSInteger)weekdayWithMondayFirst;
- (NSString *)weekdayStringWithMondayFirst;
+ (NSArray *)weekdayStrings;

- (NSInteger)weekdayOrdinal;
- (NSInteger)quarter NS_AVAILABLE(10_6, 4_0);
- (NSInteger)weekOfMonth NS_AVAILABLE(10_7, 5_0);
- (NSInteger)weekOfYear NS_AVAILABLE(10_7, 5_0);
- (NSInteger)yearForWeekOfYear NS_AVAILABLE(10_7, 5_0);

+ (NSDate *)dateWithYear:(int)year month:(int)month day:(int)day;

+ (NSInteger)numberOfDaysInYear:(int)year month:(int)month;

- (NSDate *)today;
+ (NSDate *)getLocaleDate;
- (BOOL)isToday;
- (BOOL)isSameDay:(NSDate *)aDate;
- (NSInteger)numberOfDaysFromDate:(NSDate *)aDate;

- (NSString *)format:(NSString *)format;

//add by zhandongyao
+ (NSDate *)dateWithMillisecondSince1970:(long long)millisecond;
+ (NSDate *)dateFromString:(NSString *)date;
+ (NSDate *)dateFromString:(NSString *)date withFormatter:(NSString *)format;
- (NSString *)getMonthDayString;
- (NSString *)getDateString;
- (NSString *)getTimeString;
- (NSString *)getDateTimeString;
- (NSString *)getDateTimeStringValue2;
- (NSString *)getDateStringWithFormatter:(NSString *)format;
+ (NSString *)getCurrentDateStringWithForamt:(NSString *)format;
+ (NSString*)getWeekDayString:(int)index;
+ (NSDate *)dateFromStringWinter:(NSString *)date;

- (long long)diffDays:(NSDate *)toDate;


-(NSDate*)startOfThisWeek;
-(NSDate*)endOfThisWeek;

// add by zhaojingxin!!

//- (NSString *)formatDateForTutoringDemand;
/**书券记录用*/
- (NSString *)smartPassedGrantTime;

- (NSString *)smartPassedTime;
- (NSString *)smartDateDescription;
- (NSString *)smartDescriptionOfDate;
///寒假作业要求
- (NSString *)smartDescriptionOfDateWinter;
//返回本周 下周 周几
- (NSString *)smartDescriptionOfDateWeekly;
- (NSString *)smartDescriptionFormat:(NSString *)format;
- (BOOL)isSameDayForUTC:(NSDate *)aDate;

// 学习圈时间规则
+ (NSString *)studyCircleCompareCurrentTime:(NSString *)currentTimeStr targerTime:(NSString *)targerTimeStr;
@end

