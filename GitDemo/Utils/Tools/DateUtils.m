//
//  DateUtils.m
//  SJB
//
//  Created by sheng yinpeng on 13-7-10.
//  Copyright (c) 2013年 sheng yinpeng. All rights reserved.
//

#import "DateUtils.h"
#import "NSDate+Category.h"

@implementation DateUtils


// 当前系统时间
+ (long long)getCurrentSystemDate
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *date = [DateUtils dateWithDaysFromDate:[NSDate date] BySubtractingDays:1];
    NSString* dateString = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *date = [DateUtils getDateByDateString:dateString];
    
    date  = [DateUtils dateWithDaysFromDate:date ByAddingDays:1];
    return date.timeIntervalSince1970;
}

// 某个时间的第前七天的时间
+ (long long)getLastSevenDayWithDate:(long long)dateStr
{
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:dateStr];
    
    NSDate *date = [DateUtils dateWithDaysFromDate:endDate BySubtractingDays:7];
//    NSString *dateString = [DateUtils getStringDateByDate:date];
    return date.timeIntervalSince1970;
}

+ (long long)getLastSameDayWithDate:(long long)dateStr
{
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:dateStr];
    NSDate *date = [DateUtils dateWithDaysFromDate:endDate BySubtractingDays:7];
    return date.timeIntervalSince1970;
}

+ (long long)getNextSameDayWithDate:(long long)dateStr
{
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:dateStr];
    NSDate *date = [DateUtils dateWithDaysFromDate:endDate ByAddingDays:7];
    return date.timeIntervalSince1970;
}

// 获取某个月的第一天和最后一天
+ (NSDictionary *)getMonthBeginAndEndWith:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return nil;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
//    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
//    NSString *endString = [myDateFormatter stringFromDate:endDate];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:[NSNumber numberWithLongLong:beginDate.timeIntervalSince1970] forKey:@"startDay"];
    [dict setObject:[NSNumber numberWithLongLong:endDate.timeIntervalSince1970] forKey:@"endDay"];
    return dict;
}

// 获取上一个月某一天
+ (NSString *)getLastMonthSomeDay
{
    NSDate *date = [DateUtils getFirstDayByMonth];
    NSDate *someDate = [DateUtils dateWithDaysFromDate:date BySubtractingDays:2];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString* dateString = [dateFormatter stringFromDate:someDate];
    return dateString;
}

+ (NSString *)getcurrentMonthSomeDay{
    NSDate *date = [NSDate date];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;

}

// 获取当前年份
+ (NSInteger)getCurrentYear
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
//    // 获取各时间字段的数值
//    NSLog(@"现在是%ld年" , comp.year);
//    NSLog(@"现在是%ld月 " , comp.month);
//    NSLog(@"现在是%ld日" , comp.day);
//    NSLog(@"现在是%ld时" , comp.hour);
//    NSLog(@"现在是%ld分" , comp.minute);
//    NSLog(@"现在是%ld秒" , comp.second);
//    NSLog(@"现在是星期%ld" , comp.weekday);
    return comp.year;
}

//NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//[dateComponents setDay:dDays];
//NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:aDate options:0];
//return newDate;


// 获取上一年份
+ (NSInteger)getLastYear
{
    return  [DateUtils getYearinterval:-1];
}
// 获取下一年份
+ (NSInteger)getNextYear
{
    return  [DateUtils getYearinterval:1];
}


// 获取距离当前年份间隔的年份 interval 大于0 之后的年份，小于0 之前的年份
+ (NSInteger)getYearinterval:(NSInteger)interval
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:interval];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:newDate];
    
    return comp.year;

}


+ (NSString *)changeFormatFrom:(long long)dateString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateString];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"MM"];
    NSString* dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)changeFormatFrom2:(long long)dateString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateString];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString* dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)changeFormatFrom3:(long long)dateString
{
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateString];
//    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//    [dateFormatter setDateFormat:@"MM-dd"];
//    NSString* dateStr = [dateFormatter stringFromDate:date];
//    return dateStr;
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:dateString];

    NSDate *date = [DateUtils dateWithDaysFromDate:currentDate BySubtractingDays:1];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString* dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

// NSDate转NSString
+ (NSString*)getStringDateByDate:(NSDate*)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
// NSString转NSDate
+ (NSDate*)getDateByDateString:(NSString*)dateStr
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}
// NSDate转NSString(带格式的转换:@"yyyy-MM-dd HH:mm:ss")
+ (NSString*)getStringDateByDate:(NSDate *)date dateFormat:(NSString*)string
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:string];
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

// NSString转NSString(带原始格式和目标格式格式的转换:@"yyyy-MM-dd HH:mm:ss")
+ (NSString *)getStringDateByString:(NSString *)aDateString formFormatString:(NSString *)formFormatString toFormatString:(NSString *)toFormatString {
    return [DateUtils getStringDateByDate:[DateUtils dateByDateString:aDateString UseFormatString:formFormatString] dateFormat:toFormatString];
}



// 当月第一天
+ (NSDate*)getFirstDayByMonth
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents* comps = [cal components:unitFlags fromDate:[NSDate date]];
    comps.day = 1;
    NSDate* firstDay = [cal dateFromComponents:comps];
    return firstDay;
}

// 当月最后一天
+ (NSDate*)getLastDayByMonth
{
	NSCalendar* cal = [NSCalendar currentCalendar];
	NSDate* currentDate = [NSDate date];
	NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:currentDate];
	NSUInteger numberOfDaysInMonth = range.length;
	
	NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit  | NSDayCalendarUnit |
	                       NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents* comps = [cal components:unitFlags fromDate:currentDate];
	comps.day = numberOfDaysInMonth;
	comps.hour = 0;
	comps.minute = 0;
	comps.second = 0;
	
	return [cal dateFromComponents:comps];
}

// 获取本月的天数
+ (NSInteger)getNumbersOfDaysByMonth
{
	NSCalendar* cal = [NSCalendar currentCalendar];
	NSDate* currentDate = [NSDate date];
	NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:currentDate];
	NSUInteger numberOfDaysInMonth = range.length;
	return numberOfDaysInMonth;
}

// 当天距离当月最后一天还有几天
+ (NSInteger)getNumbersOfDaysToLastDay
{
	NSCalendar* cal = [NSCalendar currentCalendar];
	NSDate* currentDate = [NSDate date];
	NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:currentDate];
	NSUInteger numberOfDaysInMonth = range.length;
	
	NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit  | NSDayCalendarUnit |
	NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents* comps = [cal components:unitFlags fromDate:currentDate];
	
	return (numberOfDaysInMonth-comps.day)+1;
}

// 当月的第几天
+ (NSDate*)getDateByDay:(NSInteger)day
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit  | NSDayCalendarUnit |
                           NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* comps = [cal components:unitFlags fromDate:[NSDate date]];
    comps.day = day;
    comps.hour = 8;
    comps.minute = 0;
    comps.second = 0;
    NSDate* date = [cal dateFromComponents:comps];
    return date;
}

// 是否是相同年月
+ (BOOL)isSameYearMonth:(NSDate*)start endDate:(NSDate*)end
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents* startComps = [cal components:unitFlags fromDate:start];
    NSDateComponents* endComps = [cal components:unitFlags fromDate:end];
    
    NSInteger startYear = startComps.year;
    NSInteger startMonth = startComps.month;
    
    NSInteger endYear = endComps.year;
    NSInteger endMonth = endComps.month;
    
    if(startYear == endYear && startMonth == endMonth){
        return YES;
    }
    return NO;
}

// 比较两个时间相差（分钟/小时/天/月/年）
+ (NSString*)compareDiffer:(NSDate*)fromDate toDate:(NSDate*)toDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit  | NSDayCalendarUnit |
                           NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents* components = [calendar components:unitFlags fromDate:fromDate toDate:toDate options:0];
    NSInteger year = components.year;
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    //NSInteger second = [components second];
    
    if(year > 0 || year < 0){
        return [NSString stringWithFormat:@"%d年",abs((int)year)];
    }
    if(month > 0 || month < 0){
        return [NSString stringWithFormat:@"%d月",abs((int)month)];
    }
    if(day > 0 || day < 0){
        return [NSString stringWithFormat:@"%d天",abs((int)day)];
    }
    if(hour > 0 || hour < 0){
        return [NSString stringWithFormat:@"%d小时",abs((int)hour)];
    }
    if(minute > 0 || minute < 0){
        return [NSString stringWithFormat:@"%d分钟",abs((int)minute)];
    }
    return [NSString stringWithFormat:@"%d分钟",1];
}

// 比较两个时间是否相差多少分钟分钟
+ (BOOL)compareDifferMinute:(NSDate*)fromDate toDate:(NSDate*)toDate minute:(NSInteger)minutes
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit  | NSDayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    if(nil == fromDate) fromDate = [NSDate date];
    if(nil == toDate) toDate = [NSDate date];
    NSDateComponents* components = [calendar components:unitFlags fromDate:fromDate toDate:toDate options:0];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    if(abs((int)year) > 0 || abs((int)month) > 0 || abs((int)day) > 0 || abs((int)hour) > 0 || abs((int)minute) >= minutes){
        return YES;
    }
    return NO;
}

// 根据基础时间按月间隔计算新的时间(如:间隔1个月,2013-08-23 16:00:00 ---> 2013-09-23 16:00:00)
+ (NSDate*)dateByAddingIntervalMonth:(NSInteger)intervalMonth basicDate:(NSDate*)basicDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* offsetComponents = [[NSDateComponents alloc] init];
    offsetComponents.month = intervalMonth;
    NSDate* lastDate = [calendar dateByAddingComponents:offsetComponents toDate:basicDate options:0];
    return lastDate;
}

/* 两个时间比较(早,晚,相等)(mask YES代表年月日时分秒全量比较,NO代表只按年月日比较)
 *(fromDate > toDate:NSOrderedDescending)降序
 *(fromDate < toDate:NSOrderedAscending)升序
 *(fromDate = toDate:NSOrderedSame)相等
 */
+ (NSComparisonResult)compareFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate isAll:(BOOL)mask
{
    if(mask){
        NSString* fromDateString = [DateUtils getStringDateByDate:fromDate dateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString* toDateString = [DateUtils getStringDateByDate:toDate dateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [fromDateString compare:toDateString];
    }else{
        NSString* fromDateString = [DateUtils getStringDateByDate:fromDate dateFormat:@"yyyy-MM-dd"];
        NSString* toDateString = [DateUtils getStringDateByDate:toDate dateFormat:@"yyyy-MM-dd"];
        return [fromDateString compare:toDateString];
    }
}

+ (NSString *)intervalSinceNowWithDate: (NSDate *) date
{
    NSTimeInterval late = [date timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    NSString *timeString = @"1分钟";
    
    NSTimeInterval cha = now - late;
    if (cha <= 0) {
        return timeString;
    }
    
    if (cha / 3600 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha / 60];
        timeString = [timeString substringToIndex:timeString.length - 7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }else if (cha / 3600 > 1 && cha / 86400 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha / 3600];
        timeString = [timeString substringToIndex:timeString.length - 7];
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
    }else if (cha / 86400 > 1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha / 86400];
        timeString = [timeString substringToIndex:timeString.length - 7];
        timeString = [NSString stringWithFormat:@"%@天前", timeString];
        
    }
    
    return timeString;
}

+ (NSString *)intervalSinceNowWithFormatDate: (NSString *) theDate
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    return  [DateUtils intervalSinceNowWithDate:d];
}


#pragma Mark -- 获取上一个月和下一个月
+(NSDate *) dateByAddingMonths: (NSInteger) dMonths by:(NSDate*)aDate{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:aDate options:0];
    return newDate;
}

+(NSDate *) dateBySubtractingMonths: (NSInteger) dMonths by:(NSDate*)aDate{
    
    return [DateUtils dateByAddingMonths:-dMonths by:aDate];
}

static const unsigned componentFlags = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit);

+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}


+ (NSInteger) monthBy:(NSDate*)aDate
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:aDate];
	return components.month;
}

+(NSDate*)dateByDateString:(NSString*)aDateString UseFormatString:(NSString*)formatString;{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:formatString];
    NSDate *date =[formatter dateFromString:aDateString];
    return date;
}

#pragma mark --days
+(NSDate *)dateWithDaysFromDate:(NSDate *)aDate ByAddingDays:(NSInteger)dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:aDate options:0];
    return newDate;
}

+(NSDate *)dateWithDaysFromDate:(NSDate *)aDate BySubtractingDays:(NSInteger)dDays
{
    return [DateUtils dateWithDaysFromDate:aDate ByAddingDays:(dDays*-1)];
}


#pragma --mark --date


+(NSDate *) dateAtStartOfDayByDate:(NSDate*)date{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* components = [cal components:componentFlags fromDate:date];
//    NSDateComponents* components = [cal components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:date];
    components.day = 1;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    NSDate* firstDay = [cal dateFromComponents:components];
    return [DateUtils getNowDateFromatAnDate:firstDay];
//    return firstDay;
    return [cal dateFromComponents:components];
    
}

+(NSDate *) dateAtEndOfDayByDate:(NSDate*)date{
    
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSUInteger numberOfDaysInMonth = range.length;
    
    NSDateComponents *components = [cal components:componentFlags fromDate:date];
    components.day = numberOfDaysInMonth;
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [DateUtils getNowDateFromatAnDate:[cal dateFromComponents:components]];
    return [cal dateFromComponents:components];
    
}

+(NSDate *) getLastDayByMonth:(NSDate*)date
{
    
    /*
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSUInteger numberOfDaysInMonth = range.length;
    
    NSDateComponents *components = [cal components:componentFlags fromDate:date];
    components.day = numberOfDaysInMonth;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [DateUtils getNowDateFromatAnDate:[cal dateFromComponents:components]];
    return [cal dateFromComponents:components];
     */
    
    
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSUInteger numberOfDaysInMonth = range.length;
    
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit  | NSDayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* comps = [cal components:unitFlags fromDate:date];
    comps.day = numberOfDaysInMonth;
    comps.hour = 0;
    comps.minute = 0;
    comps.second = 0;
    
    return [cal dateFromComponents:comps];
    
}

+ (NSDate *) getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}
+ (BOOL)isSameDayWithTimestamp:(long long)date1 date2:(long long)date2{
    
    NSDate *one  = [NSDate dateWithTimeIntervalInMilliSecondSince1970:date1];
    
    NSDate *two = [NSDate dateWithTimeIntervalInMilliSecondSince1970:date2];
    
    return [DateUtils isSameDay:one date2:two];
}
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [DateUtils currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

+(BOOL)isSameYearMonthWithTimestamp:(long long)start endDate:(long long)end{
    NSDate *one  = [NSDate dateWithTimeIntervalSince1970:start];
    
    NSDate *two = [NSDate dateWithTimeIntervalInMilliSecondSince1970:end];
    
    return [self isSameYearMonth:one endDate:two];
}

@end
