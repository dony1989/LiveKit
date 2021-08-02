//
//  NSDate+Extention.m
//  YunXiao
//
//  Created by wbitos on 14-10-18.
//  Copyright (c) 2014年 YunXiao. All rights reserved.
//

#import "NSDate+Extention.h"

@implementation NSDate (Extention)
- (NSInteger)year {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [comps year];
}

- (NSInteger)month {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitMonth fromDate:self];
    return [comps month];
}

- (NSInteger)day {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitDay fromDate:self];
    return [comps day];
}

- (NSInteger)hour {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitHour fromDate:self];
    return [comps hour];
}

- (NSInteger)minute {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitMinute fromDate:self];
    return [comps minute];
}

- (NSInteger)second {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitSecond fromDate:self];
    return [comps second];
}

- (NSInteger)nanosecond NS_AVAILABLE(10_7, 5_0) {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitNanosecond fromDate:self];
    return [comps nanosecond];
}

- (NSInteger)weekday {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:self];
    return [comps weekday];
}

- (NSInteger)weekdayWithMondayFirst {
    NSInteger i = [self weekday] - 1;
    return (i == 0) ? 7 : i;
}

- (NSString *)weekdayStringWithMondayFirst {
    return [NSDate weekdayStrings][[self weekdayWithMondayFirst]];
}

+ (NSArray *)weekdayStrings {
    static NSArray *strings = nil;
    if (strings == nil) {
        strings = @[@"MON", @"TUE", @"WEN", @"THU", @"FRI", @"SAT", @"SUN"];
    }
    return strings;
}

- (NSInteger)weekdayOrdinal {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekdayOrdinal fromDate:self];
    return [comps weekdayOrdinal];
}

- (NSInteger)quarter NS_AVAILABLE(10_6, 4_0) {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitQuarter fromDate:self];
    return [comps quarter];
}

- (NSInteger)weekOfMonth NS_AVAILABLE(10_7, 5_0) {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekOfMonth fromDate:self];
    return [comps weekOfMonth];
}

- (NSInteger)weekOfYear NS_AVAILABLE(10_7, 5_0) {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekOfYear fromDate:self];
    return [comps weekOfYear];
}

- (NSInteger)yearForWeekOfYear NS_AVAILABLE(10_7, 5_0) {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitYearForWeekOfYear fromDate:self];
    return [comps yearForWeekOfYear];
}

+ (NSDate *)dateWithYear:(int)year month:(int)month day:(int)day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:day];
    [dateComponents setHour:12];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    [dateComponents setNanosecond:0];
    return [calendar dateFromComponents:dateComponents];
}

+ (NSInteger)numberOfDaysInYear:(int)year month:(int)month {
    int days = 30;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            days = 31;
            break;
        case 2:
        {
            if ((year % 4==0 && year % 100!=0) || year % 400==0) {
                days = 29;
            }
            else {
                days = 28;
            }
        }
            break;
        default:
        {
            days = 30;
        }
            break;
    }
    return days;
}

- (NSDate *)today {
    return [NSDate date];
}

+ (NSDate *)getLocaleDate {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

- (BOOL)isToday {
    NSDate *today = [self today];
    return [self isSameDay:today];
}

- (BOOL)isSameDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps1 = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    NSDateComponents *comps2 = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    return comps1.year == comps2.year && comps1.month == comps2.month && comps1.day == comps2.day;
}

- (BOOL)isSameDayForUTC:(NSDate *)aDate
{
    if (aDate == nil || ![aDate isKindOfClass:[NSDate class]]) {
        return NO;
    }
    NSString *aDateString = [aDate getDateString];
    NSString *selfDateString = [self getDateString];
    return [aDateString isEqualToString:selfDateString];
}

- (NSInteger)numberOfDaysFromDate:(NSDate *)aDate {
    NSDate *fromDate = [NSDate dateFromString:[aDate getDateStringWithFormatter:@"yyyy-MM-dd 00:00:00"]];
    NSDate *toDate = [NSDate dateFromString:[self getDateStringWithFormatter:@"yyyy-MM-dd 00:00:00"]];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay
                                                fromDate:fromDate
                                                  toDate:toDate
                                                 options:0];
    
    return [components day];
}

- (NSInteger)numberOfDaysFromDateWinter:(NSDate *)aDate {
    NSDate *fromDate = [NSDate dateFromString:[aDate smartDescriptionFormat:@"yyyy-MM-dd 00:00:00"]];
    NSDate *toDate = [NSDate dateFromString:[self smartDescriptionFormat:@"yyyy-MM-dd 00:00:00"]];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay
                                                fromDate:fromDate
                                                  toDate:toDate
                                                 options:0];
    
    return [components day];
}

- (NSString *)format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:@"GMT"];
    [formatter setTimeZone:timezone];
    return [formatter stringFromDate:self];
}

//add by zhandongyao
+ (NSDate *)dateWithMillisecondSince1970:(long long)millisecond
{
    return [NSDate dateWithTimeIntervalSince1970:millisecond/1000.0];
}

+ (NSDate *)dateFromString:(NSString *)date
{
    return [self dateFromString:date withFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)dateFromStringWinter:(NSString *)date
{
    return [self dateFromString:date withFormatter:@"yyyy-MM-dd"];
}

+ (NSDate *)dateFromString:(NSString *)date withFormatter:(NSString *)format
{
    NSDateFormatter *formater1=[[NSDateFormatter alloc]init];
    formater1.dateFormat=format;
    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:@"GMT"];
    [formater1 setTimeZone:timezone];
    return [formater1 dateFromString:date];
}

- (NSString *)getMonthDayString {
    return [self getDateStringWithFormatter:@"MM月dd日"];
}

- (NSString *)getDateString
{
    return [self getDateStringWithFormatter:@"yyyy-MM-dd"];
}

- (NSString *)getDateTimeString
{
    return [self getDateStringWithFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)getTimeString {
    return [self getDateStringWithFormatter:@"HH:mm:ss"];
}

- (NSString *)getDateTimeStringValue2 {
    return [self getDateStringWithFormatter:@"MM-dd HH:mm"];
}


- (NSString *)getDateStringWithFormatter:(NSString *)format
{
    NSDateFormatter *formater1=[[NSDateFormatter alloc]init];
    formater1.dateFormat= format;
    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:@"GMT"];
    [formater1 setTimeZone:timezone];
    return [formater1 stringFromDate:self];
}

+ (NSString *)getCurrentDateStringWithForamt:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *currentDate = [NSDate date];
    return [formatter stringFromDate:currentDate];
}




+(NSString*)getWeekDayString:(int)index
{
    NSArray *daysInWeeks = [[NSArray alloc]initWithObjects:@"",@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    return [daysInWeeks objectAtIndex:index];
}

- (long long)diffDays:(NSDate *)toDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setLocale:[NSLocale currentLocale]];
    [gregorian setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit
                                                fromDate:self
                                                  toDate:toDate
                                                 options:0];
    
    NSInteger days = [components day];
    return days;
}

-(NSDate*)startOfThisWeek
{
    return [[self startOfWeekWithOffset:0] dateByAddingTimeInterval:24*60*60];
}

-(NSDate*)endOfThisWeek
{
    return [[self endOfWeekWithOffset:0] dateByAddingTimeInterval:24*60*60];
}

-(NSDate*)startOfWeekWithOffset:(int)offset
{
    offset = offset -1;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:self];
    [components setWeekday:1];
    [components setWeekOfMonth:[components weekOfMonth]+offset];
    //[components setWeek:[components week]+offset];
    
    return [gregorian dateFromComponents: components];
}

-(NSDate*)endOfWeekWithOffset:(int)offset
{
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:self];
    [components setWeekday:7];
    [components setWeekOfMonth:[components weekOfMonth]+offset];
    //[components setWeek:[components week]+offset];
    return [gregorian dateFromComponents: components];
}

- (NSString *)smartPassedTime {
    NSDate *today = [self today];
    /*
     time>2d 显示x月x日
     2d<=time<3d 显示 2天前
     1d<=time<2dh 显示昨天
     1h<=time<1d 显示x小时前 <--- 注：此处调整，“x小时” 一定是在同一个自然日内
     1min<=time<60min 显示x分钟前
     time<1min 显示 刚刚
     */
    NSString *passedTime = [self format:@"M月d日"];
    if (self.year == today.year) {
        NSTimeInterval itv = [[self today] timeIntervalSinceDate:self];
        
        if ([self isToday]) {
            int hour = itv / 3600;
            if (hour == 0) {
                int minute = itv / 60;
                if (minute == 0) {
                    passedTime = @"刚刚";
                }
                else {
                    passedTime = [NSString stringWithFormat:@"%d分钟前", minute];
                }
            }
            else {
                passedTime = [NSString stringWithFormat:@"%d小时前", hour];
            }
        }
        else {
            int days = (int)[today numberOfDaysFromDate:self];
            
            switch (days) {
                case 0:
                case 1:
                {
                    passedTime = @"昨天";
                }
                    break;
                case 2:
                {
                    passedTime = @"2天前";
                }
                    break;
                default:
                    break;
            }
            
        }
    }
    else {
        passedTime = [self format:@"yyyy年M月d日"];
    }
    return passedTime;
}

-(NSString *)smartPassedGrantTime {
    NSDate *today = [self today];
    /*
     time>2d 显示x月x日
     2d<=time<3d 显示 2天前
     1d<=time<2dh 显示昨天
     1h<=time<1d 显示x小时前 <--- 注：此处调整，“x小时” 一定是在同一个自然日内
     1min<=time<60min 显示x分钟前
     time<1min 显示 刚刚
     */
    NSString *passedTime = [self format:@"MM月dd日 HH:mm"];
    if (self.year == today.year) {
        if ([self isToday]) {
            passedTime = [NSString stringWithFormat:@"今天 %@",[self format:@"HH:mm"]];
            
        }
        else {
            int days = (int)[today numberOfDaysFromDate:self];
            
            switch (days) {
                case 0:
                case 1:
                {
                    passedTime = [NSString stringWithFormat:@"昨天 %@",[self format:@"HH:mm"]];
                }
                    break;
                    //                case 2:
                    //                {
                    //                    passedTime = @"2天前";
                    //                }
                    //                    break;
                default:
                    break;
            }
            
        }
    }
    else {
        passedTime = [self format:@"MM月dd日 HH:mm"];
    }
    return passedTime;
}

- (NSString *)smartDateDescription {
    NSDate *today = [self today];
    /*
     time>2d 显示x月x日
     2d<=time<3d 显示 2天前
     1d<=time<2dh 显示昨天
     1h<=time<1d 显示x小时前 <--- 注：此处调整，“x小时” 一定是在同一个自然日内
     1min<=time<60min 显示x分钟前
     time<1min 显示 刚刚
     */
    NSString *passedTime = [self format:@"M月d日"];
    if (self.year == today.year) {
        if ([self isToday]) {
            passedTime = @"今天";
        }
        else {
            int days = (int)[today numberOfDaysFromDate:self];
            switch (days) {
                case 0:
                case 1:
                {
                    passedTime = @"昨天";
                }
                    break;
                case 2:
                {
                    passedTime = @"2天前";
                }
                    break;
                default:
                    break;
            }
            
        }
    }
    else {
        passedTime = [self format:@"yyyy年M月d日"];
    }
    return passedTime;
}

- (NSString *)smartDescriptionOfDate {
    NSDate *date = self;
    
    NSDate *today = [NSDate date];
    
    /*
     time>2d 显示x月x日
     2d<=time<3d 显示 2天前
     1d<=time<2dh 显示昨天
     1h<=time<1d 显示x小时前 <--- 注：此处调整，“x小时” 一定是在同一个自然日内
     1min<=time<60min 显示x分钟前
     time<1min 显示 刚刚
     */
    NSString *passedTime = [date smartDescriptionFormat:@"M月d日"];
    if (date.year == today.year) {
        if ([date isToday]) {
            passedTime = [date smartDescriptionFormat:@"今天"];
        }
        else {
            int days = (int)[today numberOfDaysFromDateWinter:date];
            switch (days) {
                case -2:
                {
                    passedTime = [date smartDescriptionFormat:@"后天"];
                }
                    break;
                case -1:
                {
                    passedTime = [date smartDescriptionFormat:@"明天"];
                }
                    break;
                case 0:
                    passedTime = [date smartDescriptionFormat:@"今天"];
                    break;
                case 1:
                {
                    passedTime = [date smartDescriptionFormat:@"昨天"];
                }
                    break;
                default:
                    break;
            }
            
        }
    }
    else {
        passedTime = [date smartDescriptionFormat:@"yyyy年M月d日"];
    }
    return passedTime;
}

- (NSString *)smartDescriptionOfDateWinter {
    NSDate *date = self;
    
    NSDate *today = [NSDate date];
    
    /*
     time>2d 显示x月x日
     2d<=time<3d 显示 2天前
     1d<=time<2dh 显示昨天
     1h<=time<1d 显示x小时前 <--- 注：此处调整，“x小时” 一定是在同一个自然日内
     1min<=time<60min 显示x分钟前
     time<1min 显示 刚刚
     */
    NSString *passedTime = [date smartDescriptionFormat:@"M月d日"];
    if (date.year == today.year) {
        if ([date isToday]) {
            passedTime = [date smartDescriptionFormat:@"今天"];
        }
        else {
            int days = (int)[today numberOfDaysFromDateWinter:date];
            switch (days) {
                case -1:
                {
                    passedTime = [date smartDescriptionFormat:@"明天"];
                }
                    break;
                case 0:
                    passedTime = [date smartDescriptionFormat:@"今天"];
                    break;
                case 1:
                {
                    passedTime = [date smartDescriptionFormat:@"昨天"];
                }
                    break;
                default:
                    break;
            }
            
        }
    }
    else {
        passedTime = [date smartDescriptionFormat:@"yyyy年M月d日"];
    }
    return passedTime;
}

- (NSString *)smartDescriptionFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timezone];
    return [formatter stringFromDate:self];
}

- (NSString *)smartDescriptionOfDateWeekly {
    NSDate *date = self;
    
    NSDate *today = [NSDate date];
    /*
     time>2d 显示x月x日
     2d<=time<3d 显示 2天前
     1d<=time<2dh 显示昨天
     1h<=time<1d 显示x小时前 <--- 注：此处调整，“x小时” 一定是在同一个自然日内
     1min<=time<60min 显示x分钟前
     time<1min 显示 刚刚
     */
    NSString *passedTime = [date smartDescriptionFormat:@"M月d日 HH:mm"];
    NSString *hour = [date smartDescriptionFormat:@"HH:mm"];
    if (date.year == today.year) {
        if ([date isToday]) {
            passedTime = [date smartDescriptionFormat:@"今天 HH:mm"];
        }
        else {
            int days = (int)[today numberOfDaysFromDate:date];
            switch (days) {
                case -1:
                {
                    passedTime = [date smartDescriptionFormat:@"明天 HH:mm"];
                }
                    break;
                default:
                {
                    NSCalendar *calendar = [NSCalendar currentCalendar];
                    int unit = NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute ;
                    
                    //1.获得当前时间的 年月日
                    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
                    NSDateComponents *sourceCmps = [calendar components:unit fromDate:date];
                    
                    // 对比时间差
                    NSDateComponents *dateCom = [calendar components:unit fromDate:[NSDate date] toDate:date options:0];
                    NSInteger subDay = labs(dateCom.day);
                    NSInteger subMonth = labs(dateCom.month);
                    NSInteger subYear = labs(dateCom.year);
                    
                    NSArray *daysInWeeks = [[NSArray alloc]initWithObjects:@"",@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
                    NSString *weeklyDay = [self weekdayStringFromDate:date];
                    NSInteger dayIndex = [daysInWeeks indexOfObject:weeklyDay];
                    if (subYear == 0 && subMonth == 0) { //当相关的差值等于零的时候说明在一个年、月、日的时间范围内，不是按照零点到零点的时间算的
                        if (subDay > 6) { //相差天数大于6肯定不在一周内/需要判断是否是下周
                            if (dayIndex + subDay < 14) {
                                
                                return [NSString stringWithFormat:@"下%@ %@",weeklyDay,hour];
                            }
                            passedTime = [date smartDescriptionFormat:@"MM-dd"];
                            return [NSString stringWithFormat:@"%@(%@) %@",passedTime,weeklyDay,hour];
                        } else { //相差的天数大于或等于后面的时间所对应的weekday则不在一周内
                            if (dateCom.day >= 0 && dateCom.hour >=0 && dateCom.minute >= 0) { //比较的时间大于当前时间
                                //西方一周的开始是从周日开始算的，周日是1，周一是2，而我们是从周一开始算新的一周
                                NSInteger chinaWeekday = sourceCmps.weekday == 1 ? 7 : sourceCmps.weekday - 1;
                                if (subDay >= chinaWeekday) {
                                    
                                    return [NSString stringWithFormat:@"下%@ %@",weeklyDay,hour];
                                } else {
                                    return [NSString stringWithFormat:@"本%@ %@",weeklyDay,hour];
                                }
                            } else {
                                NSInteger chinaWeekday = sourceCmps.weekday == 1 ? 7 : nowCmps.weekday - 1;
                                if (subDay >= chinaWeekday) { //比较的时间比当前时间小，已经过去的时间
                                    //无效时间
                                    return nil;
                                } else {
                                    
                                    return [NSString stringWithFormat:@"本%@ %@",weeklyDay,hour];
                                }
                            }
                        }
                    } else { //时间范围差值超过了一年或一个月的时间范围肯定就不在一个周内了
                        
                        passedTime = [date smartDescriptionFormat:@"MM-dd"];
                        
                        
                        return [NSString stringWithFormat:@"%@(%@) %@",passedTime,weeklyDay,hour];
                    }
                    
                }
                    break;
            }
            
        }
    }
    else {
        NSString *weeklyDay = [self weekdayStringFromDate:date];
        passedTime = [date smartDescriptionFormat:@"MM-dd"];
        
        return  [NSString stringWithFormat:@"%@(%@) %@",passedTime,weeklyDay,hour];
        
    }
    return passedTime;
}

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+ (NSString *)studyCircleCompareCurrentTime:(NSString *)currentTimeStr targerTime:(NSString *)targerTimeStr
{
   //把字符串转为NSdate
   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
   NSDate *timeDate = [dateFormatter dateFromString:targerTimeStr];
   NSDate *currentDate = [dateFormatter dateFromString:currentTimeStr];
   NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
   long temp = 0;
   NSString *result;
   if (timeInterval/60 < 1)
   {
       result = [NSString stringWithFormat:@"刚刚"];
   }
   else if((temp = timeInterval/60) <60){
       result = [NSString stringWithFormat:@"%ld分钟前",temp];
   }
   else if((temp = temp/60) <24){
       result = [NSString stringWithFormat:@"%ld小时前",temp];
   }
   else if((temp = temp/24) <30){
       result = [NSString stringWithFormat:@"%ld天前",temp];
    }
   else if((temp = temp/30) <12){
       result = [NSString stringWithFormat:@"%ld月前",temp];
    }
   else{
       temp = temp/12;
       result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
 }

@end

