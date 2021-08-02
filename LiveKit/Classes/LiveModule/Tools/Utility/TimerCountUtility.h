//
//  TimerCountUtility.h
//  Yuwen
//
//  Created by panyu_lt on 16/5/12.
//  Copyright © 2016年 yimilan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TimerCountUtility : NSObject

@property (nonatomic, copy  ) NSString *startTime;
@property (nonatomic, copy  ) NSString *endTime;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval leftTime;
@property (nonatomic, copy  ) NSString *timeOverString;
//默认都精确到时分秒
@property (nonatomic, assign) BOOL isRemainSecond;
@property (nonatomic, assign) BOOL isRemainMin;
@property (nonatomic, assign) BOOL isRemainHour;

@property (nonatomic, copy  ) NSString *prefix;
@property (nonatomic, copy  ) NSString *sufix;

@property (nonatomic, weak ) UILabel *setedLabel;
/**
 *  时间到的回调
 */
@property (copy, readwrite, nonatomic) void (^completionHandler)(id);

-(void)startUpateLabel;
// 通过具体的时间字符串得到具体的时间戳
+ (NSString *_Nullable)getTimestampDateStr:(NSString *_Nullable)dateStr withFormatStr:(NSString *_Nullable)formatStr;
// 获得当前时间戳乘以1000
+ (NSString *_Nullable)getCurrentTimeIntevalTakeThousand;
// 获得当前时间戳
+ (NSString *_Nullable)getCurrentTimeInteval;
+(NSString *)calculatUseTime:(NSTimeInterval)durationTime;//传入参数durationTime单位为秒：s
+(NSString *)timeIntervalFromNow:(NSString *)time;
+(NSString *)timeIntervalFromGrantTimeNow:(NSString *)time;
+(NSString *)timeIntervalFromLoginTimeNow:(NSString *)time;

+(NSString *)timeIntervalFromLoginTimeDownLoadNow:(NSString *)time;//只有今天


+(NSDate *)dateWithString:(NSString *)time;
+(NSDate *)utcTimeToLocaleDate:(NSDate *)utcTime;
+ (NSDate *)todayUTC;
// 获取当前是哪年，哪月
+ (NSString *)getCurrentYear;
+ (NSString *)getCurrentMonth;


/**
 格式化得到冒号分割的时间格式：01:01:12
 @param timeCount 传入秒数
 @return 冒号分割的时间格式
 */
+ (NSString *)formateTimeCount:(long)timeCount mustHour:(BOOL)mustHour mustMin:(BOOL)mustMin mustSec:(BOOL)mustSec;
// 得到M月dd日 HH:mm
+ (NSString *)getIntegrateTimeStringWithDateString:(NSString *)dateString;

+ (NSString *)getAwardQuestionCountTimeWithTimestamp:(NSInteger)timestamp;
// 主题学习首页百万答题倒计时显示天/时/分
+ (NSString *)getHomeBillionQuestionCountTimeWithTimestamp:(NSInteger)timestamp;
+ (NSInteger)getTotalDaysWithTimestamp:(NSString *)timestamp;
// 通过时间字符串得到想要的年、月、日、小时、分钟、秒
+ (NSString *)getYearMouthDayHourMinuteSecondsWithDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat resultFormat:(NSString *)resultFormat;

// 通过date和具体格式获得年月日
+
(NSString *)getYearMouthDayHourMinuteSecondsWithDate:(NSDate *)date resultFormat:(NSString *)resultFormat;
// 百万答题日期显示
+ (NSString *)billionAnswerTimeIntervalFromNow:(NSString *)timeString;

/**
 计算时间差 XX天XX小时
 
 @param startTime 开始j时间
 @param endTime 结束时间
 @return 格式化字符串
 */
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

@end

