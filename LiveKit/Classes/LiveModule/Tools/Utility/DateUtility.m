//
//  DateUtility.m
//  Yuwen
//
//  Created by panyu_lt on 2017/9/6.
//  Copyright © 2017年 yimilan. All rights reserved.
//

#import "DateUtility.h"
#import "StringUtility.h"
#import "NSDate+Extention.h"


NSDateFormatter * _innerDateFormatter = nil;

@implementation DateUtility

+ (void)load
{
    _innerDateFormatter = [NSDateFormatter new];
}

+ (NSTimeInterval)timeIntervalSinceNow:(NSString *)dateString
{
    NSDate *nowDate = [NSDate date];
    NSDate *targetDate = [self dateFromString:dateString];
    NSTimeInterval interval = [targetDate timeIntervalSinceDate:nowDate];
    return interval;
}

+ (NSTimeInterval)timeIntervalFrom:(NSString *)startDate to:(NSString *)endDate
{
    NSDate *start = [self dateFromString:startDate];
    NSDate *end = [self dateFromString:endDate];
    NSTimeInterval interval = [end timeIntervalSinceDate:start];
    return interval;
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    return [self dateFromString:dateString withFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)dateFromString:(NSString *)date withFormatter:(NSString *)format
{
    NSDateFormatter *formater = _innerDateFormatter;
    formater.dateFormat = format;
    return [formater dateFromString:date];
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    return [self stringFromDate:date withFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)stringFromDate:(NSDate *)date withFormatter:(NSString *)format
{
    NSDateFormatter *formater = _innerDateFormatter;
    formater.dateFormat = format;
    return [formater stringFromDate:date];
}

+ (BOOL)isSameDayBetween:(NSString *)dateAString and:(NSString *)dateBString
{
    NSDate *dateA = [self dateFromString:dateAString];
    NSDate *dateB = [self dateFromString:dateBString];
    return [self isSameDayCompare:dateA with:dateB];
}

+ (BOOL)isSameDayCompare:(NSDate *)dateA with:(NSDate *)dateB
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps1 = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:dateA];
    NSDateComponents *comps2 = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:dateB];
    return comps1.year == comps2.year && comps1.month == comps2.month && comps1.day == comps2.day;
}

+ (NSComparisonResult)compareDateA:(NSDate *)dateA withDateB:(NSDate *)dateB
{
    return [dateA compare:dateB];
}

+ (NSString *)timeStringWithTimeCount:(int)timeCount hour:(BOOL)hour min:(BOOL)min sec:(BOOL)sec
{
    if (timeCount <= 0) {
        return @"0秒";
    }
    int days = timeCount / (24 * 60 *60);
    timeCount = timeCount % (24 * 60 * 60);
    
    int hours = timeCount / (60 * 60);
    timeCount = timeCount % (60 * 60);
    
    int mins = timeCount / 60;
    
    int secs = timeCount % 60;
    
    NSString *daysString = [self getTimeCount:days sufixString:@"天"];
    
    NSString *hoursString = [self getTimeCount:hours sufixString:@"小时"];
    
    NSString *minString = [self getTimeCount:mins sufixString:@"分"];
    
    if (secs == 0) {
        minString = [NSString stringWithFormat:@"%d分钟",mins];
    }
   
    NSString *secString = [self getTimeCount:secs sufixString:@"秒"];
    
    NSMutableString *finalString = [NSMutableString new];
    [finalString appendString:daysString];
    
    if (hour) {
        [finalString appendString:hoursString];
        if (min) {
            [finalString appendString:minString];
            if (sec) {
                [finalString appendString:secString];
            }
        }
    }
    return finalString;
}

+ (NSString *)getTimeCount:(int)timeCount sufixString:(NSString *)sufixString
{
    
    NSString *timeCountString = [NSString stringWithFormat:@"%d%@",timeCount,sufixString];
    if (timeCount == 0) {
        timeCountString = @"";
    }
    return timeCountString;
    
}

+ (NSArray *)getMonthFirstAndLastDayWith:(NSString *)dateStr{
    
    //获取当月的第一天和最后一天
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @[@"",@""];
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstString = [myDateFormatter stringFromDate: firstDate];
    NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    return @[firstString, lastString];
}

+ (NSTimeInterval)getTotalTimeWithStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    
    //按照日期格式创建日期格式句柄
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //将日期字符串转换成Date类型
    NSDate *startDate = [dateFormatter dateFromString:startTime];
    NSDate *endDate = [dateFormatter dateFromString:endTime];
    
    //将日期转换成时间戳
    NSTimeInterval start = [startDate timeIntervalSince1970]*1;
    NSTimeInterval end = [endDate timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    return value;
}

//计算两个日期字符串的差值, 并格式化
+ (NSString *)getTotalFormmatTimeWithStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    
    //按照日期格式创建日期格式句柄
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //将日期字符串转换成Date类型
    NSDate *startDate = [dateFormatter dateFromString:startTime];
    NSDate *endDate = [dateFormatter dateFromString:endTime];
    
    //将日期转换成时间戳
    NSTimeInterval start = [startDate timeIntervalSince1970]*1;
    NSTimeInterval end = [endDate timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    
    //计算具体的天，时，分，秒
    int second = (int)value %60;//秒
    int minute = (int)value / 60 % 60;
    int house = (int)value / 3600;
    int day = (int)value / (24 * 3600);
    
    //将获取的int数据重新转换成字符串
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"%d天%d小时%d分%d秒",day,house,minute,second];
    }else if (day==0 && house != 0) {
        str = [NSString stringWithFormat:@"%d小时%d分%d秒",house,minute,second];
    }else if (day== 0 && house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"%d分%d秒",minute,second];
    }else{
        str = [NSString stringWithFormat:@"%d秒",second];
    }

    //返回string类型的总时长
    return str;
}

+ (NSString *)getMonthDayTimeStringWithDateString:(NSString *)dateString {
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

+ (BOOL)isSameYearWithDate:(NSDate *)date {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date];
    return (components1.year == components2.year);
}

@end
