//
//  TimeUtility.m
//  YuwenParent
//
//  Created by xiaoshuang on 2019/4/11.
//  Copyright © 2019年 xiaoshuang. All rights reserved.
//

#import "TimeUtility.h"
#import "LiveModuleHeader.h"

@implementation TimeUtility
+ (NSString *_Nullable)getCurrentTimeInteval {
    NSTimeInterval currentTimeInteval = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f", currentTimeInteval];
}
+ (NSString *_Nullable)getCurrentTimeIntevalTakeThousand {
    NSTimeInterval currentTimeInteval = [[NSDate date] timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%.0f", currentTimeInteval];
}
// 通过具体的时间字符串得到具体的时间戳
+ (NSString *_Nullable)getTimestampDateStr:(NSString *_Nullable)dateStr withFormatStr:(NSString *_Nullable)formatStr {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    if (![StringUtility isStringNotEmptyOrNil:formatStr]) {
        formatStr = @"yyyy-MM-dd HH:mm:ss";
    }
    [inputFormatter setDateFormat:formatStr];
    NSDate* outputDate = [inputFormatter dateFromString:dateStr];
    NSTimeInterval timeInterval = [outputDate timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%.0f", timeInterval];;
}

+ (NSString *)getStringWithDateString:(NSString *)dateString originDateStringFormat:(NSString *)originDateStringFormat targetStringFormat:(NSString *)targetStringFormat {
    if(![StringUtility isStringNotEmptyOrNil:dateString]) {
        return @"";
    }
    if (![StringUtility isStringNotEmptyOrNil:targetStringFormat]) {
        return @"";
    }
    if (![StringUtility isStringNotEmptyOrNil:originDateStringFormat]) {
        originDateStringFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = originDateStringFormat;
    
    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:@"GMT"];
    [fmt setTimeZone:timezone];
    
    NSDate *date = [fmt dateFromString:dateString];
    return [date format:targetStringFormat];
}

+ (NSString *)getRemainTimeWithDateString:(NSString *)dateString dateStringFormat:(NSString *)dateStringFormat {
    if(![StringUtility isStringNotEmptyOrNil:dateString]) {
        return @"";
    }
    if (![StringUtility isStringNotEmptyOrNil:dateStringFormat]) {
        dateStringFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    NSString *endTimeTimeIntevalString = [self getTimestampDateStr:dateString withFormatStr:dateStringFormat];
    NSString *nowTimeIntevalString = [self getCurrentTimeIntevalTakeThousand];
    NSTimeInterval leftTime = ([endTimeTimeIntevalString longLongValue] - [nowTimeIntevalString longLongValue]) / 1000;
    NSInteger leftDays = leftTime / (60*60*24);
    if (leftDays) {
        return [NSString stringWithFormat:@"%ld天",leftDays];
    }
    NSInteger leftHours = leftTime / (60*60);
    if(leftHours){
        return [NSString stringWithFormat:@"%ld小时",leftHours];
    }
    NSInteger leftMins = leftTime / 60;
    if(leftMins){
        return [NSString stringWithFormat:@"%ld分钟",leftMins];
    }
    return @"";
}

+ (BOOL)isSameDayCompare:(NSDate *)dateA with:(NSDate *)dateB
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps1 = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:dateA];
    NSDateComponents *comps2 = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:dateB];
    return comps1.year == comps2.year && comps1.month == comps2.month && comps1.day == comps2.day;
}

//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    //获取系统当前时间
    NSDate *currentDate = date;
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置转换格式
    [dateFormatter setDateFormat:format];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    return currentDateString;
}

//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string
{
    //需要转换的字符串
    NSString *dateString = string;
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

//当前时间是否在时间段内
+(BOOL)judgeTimeByStartAndEnd:(NSString *)startStr EndTime:(NSString *)endStr currentTime:(NSString *)currentTime
{
    NSDate *current = [NSDate dateFromString:currentTime];
    NSDate *start = [NSDate dateFromString:startStr];
    NSDate *expire = [NSDate dateFromString:endStr];
    
    if ([current compare:start] == NSOrderedDescending && [current compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

//获取当月的第一天和最后一天
+ (NSArray *)getMonthFirstAndLastDayWith:(NSString *)dateStr{
    
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

@end
