

//
//  TimerCountUtility.m
//  Yuwen
//
//  Created by panyu_lt on 16/5/12.
//  Copyright © 2016年 yimilan. All rights reserved.
//

#import "TimerCountUtility.h"
#import <YYKit/YYKit.h>
#import "NSDate+Extention.h"
#import "StringUtility.h"

@interface TimerCountUtility()
@property (nonatomic, strong) NSDate *fromDate;
@property (nonatomic, strong) NSDate *toDate;
@property (nonatomic, assign) BOOL isSameEndTime;
@end

@implementation TimerCountUtility


#pragma mark - timer count action

-(void)startCount
{
    if (self.toDate) {
        NSDate *nowDate = [TimerCountUtility utcTimeToLocaleDate:[NSDate date]];
        self.leftTime = [self.toDate timeIntervalSinceDate:nowDate];//单位：秒
        [self startATimer];
    }
}

-(void)startATimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    [self refreshDeadlineLabelTime];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshDeadlineLabelTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

-(void)refreshDeadlineLabelTime
{
    NSTimeInterval leftTime = (--self.leftTime);
    int leftDays = leftTime / (60*60*24);
    leftTime = (int)leftTime % (60*60*24);
    int leftHours = leftTime / (60*60);
    leftTime = (int)leftTime % (60*60);
    int leftMins = leftTime / 60;
    int leftSeconds = (int)leftTime %60;
    
    if (!leftDays && !leftHours && !leftMins && !leftSeconds) {//如果时间刚刚结束
        [self.timer invalidate];
        self.timer = nil;
        self.setedLabel.text = self.timeOverString;
        self.toDate = nil;
        if (self.completionHandler) {
            self.completionHandler(nil);
        }
    }else{
        NSString *remainDays = [NSString stringWithFormat:@"%d天",leftDays];
        NSString *remainHours = [NSString stringWithFormat:@"%d小时",leftHours];
        NSString *remainMins = [NSString stringWithFormat:@"%d分钟",leftMins];
        //NSString *remainSeconds = [NSString stringWithFormat:@"%d秒",leftSeconds];
        
        NSString *remainTime = nil;
        if (leftDays) {
            remainTime = [NSString stringWithFormat:@"%@",remainDays];
        }else if(leftHours){
            remainTime = [NSString stringWithFormat:@"%@",remainHours];
            
        }else if(leftMins){
            remainTime = [NSString stringWithFormat:@"%@",remainMins];
        }
        
        remainTime = [NSString stringWithFormat:@"%@%@%@",self.prefix ? self.prefix:@"",remainTime,self.sufix ? self.sufix:@""];
        
        //        remainTime = [NSString stringWithFormat:@"%@%@%@%@%@%@",self.prefix ? self.prefix:@"",leftDays>0?remainDays:@"",leftHours>0 && self.isRemainHour?remainHours:@"",leftMins>0 && self.isRemainMin?remainMins:@"",leftSeconds>0 && self.isRemainSecond?remainSeconds:@"",self.sufix ? self.sufix:@""];
        self.setedLabel.text = remainTime;
    }
    
}

-(void)startUpateLabel
{
    if ( self.toDate) {
        if (self.isSameEndTime == NO) {
            [self startCount];
        }
    }
}

-(void)setEndTime:(NSString *)endTime
{
    if (![_endTime isEqualToString:endTime]) {
        _endTime = [endTime copy];
        self.toDate = [TimerCountUtility dateWithString:endTime];
        self.isSameEndTime = NO;
    }else{
        self.isSameEndTime = YES;
    }
    
}

// 通过具体的时间字符串得到具体的时间戳
+ (NSString *_Nullable)getTimestampDateStr:(NSString *_Nullable)dateStr withFormatStr:(NSString *_Nullable)formatStr {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:formatStr];
    NSDate* outputDate = [inputFormatter dateFromString:dateStr];
    NSTimeInterval timeInterval = [outputDate timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%.0f", timeInterval];;
}

+ (NSString *_Nullable)getCurrentTimeIntevalTakeThousand {
    NSTimeInterval currentTimeInteval = [[NSDate date] timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%.0f", currentTimeInteval];
}

+ (NSString *_Nullable)getCurrentTimeInteval {
    NSTimeInterval currentTimeInteval = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f", currentTimeInteval];
}

+(NSDate *)dateWithString:(NSString *)time {
    
    if (time && [time isKindOfClass:[NSString class]]) {
        
        static NSString *GLOBAL_TIMEFORMAT = @"yyyy-MM-dd HH:mm:ss";
        NSDateFormatter* formate=[[NSDateFormatter alloc]init];
        [formate setDateFormat:GLOBAL_TIMEFORMAT];
        [formate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        NSDate *date = [formate dateFromString:time];
        return date;
    }
    return  nil;
}

+ (NSDate *)utcTimeToLocaleDate:(NSDate *)utcTime //utc毫秒数转化为本地日期
{
    //NSDate *date = [NSDate dateWithTimeIntervalSince1970:(utcTimeMilliSeconds/1000)];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: utcTime];
    NSDate *localeDate = [utcTime dateByAddingTimeInterval: interval];
    return localeDate;
}

+(NSString *)calculatUseTime:(NSTimeInterval)durationTime{
    
    NSTimeInterval leftTime = durationTime;
    int leftDays = leftTime / (60*60*24);
    leftTime = (int)leftTime % (60*60*24);
    int leftHours = leftTime / (60*60);
    leftTime = (int)leftTime % (60*60);
    int leftMins = leftTime / 60;
    int leftSeconds = (int)leftTime %60;
    NSString *remainDays = [NSString stringWithFormat:@"%d天",leftDays];
    NSString *remainHours = [NSString stringWithFormat:@"%d小时",leftHours];
    NSString *remainMins = [NSString stringWithFormat:@"%d分",leftMins];
    NSString *remainSeconds = [NSString stringWithFormat:@"%d秒",leftSeconds];
    NSString *remainTime = [NSString stringWithFormat:@"%@%@%@%@",leftDays>0?remainDays:@"",leftHours>0?remainHours:@"",leftMins>0?remainMins:@"",leftSeconds>0?remainSeconds:@""];
    NSString *time = (remainTime && remainTime.length > 0)?remainTime:@"0秒";
    return time;
}

+(NSString *)timeIntervalFromGrantTimeNow:(NSString *)time {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy.MM.dd HH:mm";
    
    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:@"GMT"];
    [fmt setTimeZone:timezone];
    
    NSDate *date = [fmt dateFromString:time];
    
    NSDate *today = [self utcTimeToLocaleDate:[NSDate date]];
    
    if (date.year != today.year) {
        return [date format:@"yyyy年MM月dd日 HH:mm"];
    }
    else {
        NSString *returnString = @"";
        int days = (int)[today numberOfDaysFromDate:date];
        switch (days) {
            case 0:
                returnString = [date format:@"今天 HH:mm"];
                break;
            case 1:
                returnString = [date format:@"昨天 HH:mm"];
                break;
            case 2:
                returnString = [date format:@"前天 HH:mm"];
                break;
            default:
                returnString = [date format:@"MM月dd日 HH:mm"];
                break;
        }
        return returnString;
    }
}

+(NSString *)timeIntervalFromLoginTimeNow:(NSString *)time {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:@"GMT"];
    [fmt setTimeZone:timezone];
    
    NSDate *date = [fmt dateFromString:time];
    
    NSDate *today = [self utcTimeToLocaleDate:[NSDate date]];
    
    NSString *returnString = @"";
    int days = (int)[today numberOfDaysFromDate:date];
    switch (days) {
        case 0:
            returnString = [date format:@"今天"];
            break;
            
        default:
        {
            if (days>=365) {
                returnString = [NSString stringWithFormat:@"%d年前",days/365];
            }else {
                returnString = [NSString stringWithFormat:@"%d天前",days];

            }
            break;
        }
    }
    return returnString;
}

+(NSString *)timeIntervalFromLoginTimeDownLoadNow:(NSString *)time {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:@"GMT"];
    [fmt setTimeZone:timezone];
    
    NSDate *date = [fmt dateFromString:time];
    
    
    NSDate *today = [self utcTimeToLocaleDate:[NSDate date]];
    
    NSString *returnString = @"";
    int days = (int)[today numberOfDaysFromDate:date];
    switch (days) {
        case 0:
            returnString = [date format:[NSString stringWithFormat:@"今天%@",[date format:@" HH:mm"]]];
            break;
            
        default:
        {
            returnString = [date format:@"yyyy-MM-dd HH:mm"];
            break;
        }
    }
    return returnString;
}

+ (NSString *)timeIntervalFromNow:(NSString *)time {
    NSDate *date = [NSDate dateFromString:time];
    NSDate *today = [self utcTimeToLocaleDate:[NSDate date]];
    
    if (date.year != today.year) {
        return [date format:@"yyyy年MM月dd日 HH:mm"];
    }
    else {
        NSString *returnString = @"";
        int days = (int)[today numberOfDaysFromDate:date];
        switch (days) {
            case 0:
                returnString = [date format:@"今天 HH:mm"];
                break;
            case 1:
                returnString = [date format:@"昨天 HH:mm"];
                break;
            case 2:
                returnString = [date format:@"前天 HH:mm"];
                break;
            default:
                returnString = [date format:@"MM月dd日 HH:mm"];
                break;
        }
        return returnString;
    }
}

+ (NSDate *)todayUTC
{
    return [self utcTimeToLocaleDate:[NSDate date]];
}
// 获取当前是哪年
+ (NSString *)getCurrentYear {
    NSDate * currentDate = [NSDate date];
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy"];
    NSString *thisYearString=[dateformatter stringFromDate:currentDate];
    return thisYearString;
}
+ (NSString *)getCurrentMonth {
    NSDate * currentDate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM"];
    NSString *thisYearString=[dateformatter stringFromDate:currentDate];
    return thisYearString;
}

+ (NSString *)formateTimeCount:(long)timeCount mustHour:(BOOL)mustHour mustMin:(BOOL)mustMin mustSec:(BOOL)mustSec
{
    long hour = timeCount/(60*60);
    timeCount -= hour *(60*60);
    long min = timeCount/60;
    timeCount -= min * 60;
    NSMutableString *timeString = [NSMutableString string];
    
    if (hour > 0 || mustHour) {
        [timeString appendFormat:@"%02ld:",hour];
    }
    
    
    if (min > 0 || mustMin) {
        [timeString appendFormat:@"%02ld:",min];
    }
    
    if (timeCount > 0 || mustSec) {
        [timeString appendFormat:@"%02ld",timeCount];
    }
    
    return timeString;
    
}

+ (NSString *)getIntegrateTimeStringWithDateString:(NSString *)dateString {
    if(![StringUtility isStringNotEmptyOrNil:dateString]) {
        return @"";
    }
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:@"GMT"];
    [fmt setTimeZone:timezone];
    
    NSDate *date = [fmt dateFromString:dateString];
    return [date format:@"M月dd日 HH:mm"];
}

+ (NSString *)getAwardQuestionCountTimeWithTimestamp:(NSInteger)timestamp {
    
    NSInteger ms = timestamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
    if (day > 0) {
        return [NSString stringWithFormat:@"%li天%02li:%02li:%02li后截止",day,hour,minute,second];
    }
    return [NSString stringWithFormat:@"%02li:%02li:%02li后截止",hour,minute,second];
}
+ (NSString *)getHomeBillionQuestionCountTimeWithTimestamp:(NSInteger)timestamp {
    if (timestamp <= 0) {
        return @"";
    }
    NSInteger ms = timestamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSString *finalString = @"";
    if (day > 0) {
        finalString = [NSString stringWithFormat:@"%li天", day];
    }
    if (hour > 0) {
        finalString = [NSString stringWithFormat:@"%@%02li时", finalString, hour];
    } else {
        if (day > 0) {
            finalString = [NSString stringWithFormat:@"%@00时", finalString];
        }
    }
    if (minute > 0) {
        finalString = [NSString stringWithFormat:@"%@%02li分", finalString, minute];
    } else {
        if (day > 0 || hour > 0) {
            finalString = [NSString stringWithFormat:@"%@00分", finalString];
        }
    }
    return finalString;
}

+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startDate = [NSDate date];
    NSDate *endDdate = [date dateFromString:endTime];//[date dateFromString:endTime];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [cal components:unitFlags fromDate:startDate toDate:endDdate options:0];
    
    // 天
    NSInteger day = [dateComponents day];
    // 小时
    NSInteger house = [dateComponents hour];
    // 分
    NSInteger minute = [dateComponents minute];
    // 秒
    NSInteger second = [dateComponents second];
    
    NSString *timeStr;
    
    if (day != 0) {
        if (house == 0) {
            timeStr = [NSString stringWithFormat:@"%zd天后开始",day];
        }else {
            timeStr = [NSString stringWithFormat:@"%zd天%zd小时后开始",day,house];
        }
        
    }
    else if (day==0 && house !=0) {
        timeStr = [NSString stringWithFormat:@"%zd小时后开始",house];
    }
    else if (day==0 && house==0 && minute!=0) {
        timeStr = [NSString stringWithFormat:@"即将开始"];
    }
    else{
        timeStr = [NSString stringWithFormat:@"即将开始"];
    }
    
    return timeStr;
}

+ (NSInteger)getTotalDaysWithTimestamp:(NSString *)timestamp {
    // 准确计算天数需要加上8小时
    NSInteger ms = [timestamp integerValue] + 8 * 60 * 60;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    NSInteger totalDays = ms / dd;// 天
    return totalDays;
}

// 通过时间字符串得到想要的年、月、日、小时、分钟、秒
+ (NSString *)getYearMouthDayHourMinuteSecondsWithDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat resultFormat:(NSString *)resultFormat {
    if(![StringUtility isStringNotEmptyOrNil:dateString]) {
        return @"";
    }
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    if (![StringUtility isStringNotEmptyOrNil:dateFormat]) {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    } else {
        fmt.dateFormat = dateFormat;
    }
    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:@"GMT"];
    [fmt setTimeZone:timezone];
    
    NSDate *date = [fmt dateFromString:dateString];
    return [date format:resultFormat];
}

// 通过date和具体格式获得年月日
+ (NSString *)getYearMouthDayHourMinuteSecondsWithDate:(NSDate *)date resultFormat:(NSString *)resultFormat {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    // 设置日期格式(为了转换成功)
    if (![StringUtility isStringNotEmptyOrNil:resultFormat]) {
        resultFormat = @"yyyy-MM-dd";
    }
    return [localeDate format:resultFormat];
}

// 百万答题日期显示
+ (NSString *)billionAnswerTimeIntervalFromNow:(NSString *)timeString {
    NSDate *date = [NSDate dateFromString:timeString];
    NSDate *today = [self utcTimeToLocaleDate:[NSDate date]];
    NSString *returnString = @"";
    int days = (int)[date numberOfDaysFromDate:today];
    switch (days) {
        case 0:
            returnString = [date format:@"今天 HH:mm"];
            break;
        case 1:
            returnString = [date format:@"明天 HH:mm"];
            break;
        case 2:
            returnString = [date format:@"后天 HH:mm"];
            break;
        default:
            returnString = [date format:@"M月dd日 HH:mm"];
            break;
    }
    return returnString;
}

@end

