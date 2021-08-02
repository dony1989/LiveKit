//
//  TimeUtility.h
//  YuwenParent
//
//  Created by xiaoshuang on 2019/4/11.
//  Copyright © 2019年 xiaoshuang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeUtility : NSObject
// 获得当前时间戳
+ (NSString *_Nullable)getCurrentTimeInteval;
+ (NSString *_Nullable)getCurrentTimeIntevalTakeThousand;
// 通过具体的时间字符串得到具体的时间戳
+ (NSString *_Nullable)getTimestampDateStr:(NSString *_Nullable)dateStr withFormatStr:(NSString *_Nullable)formatStr;
// 通过具体的时间字符串得到想要的时间字符串 例如：传入 2019-02-02 19：08：08 得到2月2日
+ (NSString *)getStringWithDateString:(NSString *)dateString originDateStringFormat:(NSString *)originDateStringFormat targetStringFormat:(NSString *)targetStringFormat;
// 得到剩余时间，目前征订活动弹窗在使用
+ (NSString *)getRemainTimeWithDateString:(NSString *)dateString dateStringFormat:(NSString *)dateStringFormat;
//  判断是否是同一天
+ (BOOL)isSameDayCompare:(NSDate *)dateA with:(NSDate *)dateB;

// NSString和NSDate换转 -xiayuaquan
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;
+ (NSDate *)dateFromString:(NSString *)string;

//当前时间是否在时间段内
+(BOOL)judgeTimeByStartAndEnd:(NSString *)startStr EndTime:(NSString *)endStr currentTime:(NSString *)currentTime;

//获取当月的第一天和最后一天
+ (NSArray *)getMonthFirstAndLastDayWith:(NSString *)dateStr;

//计算两个日期字符串的差值
+ (NSTimeInterval)getTotalTimeWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

//计算两个日期字符串的差值, 并格式化
+ (NSString *)getTotalFormmatTimeWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

@end

NS_ASSUME_NONNULL_END
