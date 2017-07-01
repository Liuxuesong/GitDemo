//
//  DateUtils.h
//  SJB
//
//  Created by sheng yinpeng on 13-7-10.
//  Copyright (c) 2013年 sheng yinpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

// 当前系统时间
+ (long long)getCurrentSystemDate;

// 某个时间的第前七天的时间(共七天)
+ (long long)getLastSevenDayWithDate:(long long)dateStr;
// 上周的同一时间
+ (long long)getLastSameDayWithDate:(long long)dateStr;
// 下周的同一时间
+ (long long)getNextSameDayWithDate:(long long)dateStr;

// 获取某个月的第一天和最后一天
+ (NSDictionary *)getMonthBeginAndEndWith:(NSString *)dateStr;
// 获取上一个月某一天
+ (NSString *)getLastMonthSomeDay;

// 获取上一个月某一天
+ (NSString *)getcurrentMonthSomeDay;

// 转换格式 yyyy-mm-dd 转成yyyy-mm
+ (NSString *)changeFormatFrom:(long long)dateString;
// 转换格式 yyyy-mm-dd 转成mm-dd
+ (NSString *)changeFormatFrom2:(long long)dateString;
//我很无奈
+ (NSString *)changeFormatFrom3:(long long)dateString;

// 获取当前年份
+ (NSInteger)getCurrentYear;
// 获取上一年份
+ (NSInteger)getLastYear;
// 获取下一年份
+ (NSInteger)getNextYear;


// NSDate转NSString
+ (NSString*)getStringDateByDate:(NSDate*)date;
// NSString转NSDate
+ (NSDate*)getDateByDateString:(NSString*)dateStr;
// NSDate转NSString(带格式的转换:@"yyyy-MM-dd HH:mm:ss")
+ (NSString*)getStringDateByDate:(NSDate *)date dateFormat:(NSString*)string;
// NSString转NSString(带原始格式和目标格式格式的转换:@"yyyy-MM-dd HH:mm:ss")
+ (NSString *)getStringDateByString:(NSString *)aDateString formFormatString:(NSString *)formFormatString toFormatString:(NSString *)toFormatString;

// 当月第一天
+ (NSDate*)getFirstDayByMonth;
// 当月最后一天
+ (NSDate*)getLastDayByMonth;
// 某月最后一天
+(NSDate *)getLastDayByMonth:(NSDate*)date;
// 获取本月的天数
+ (NSInteger)getNumbersOfDaysByMonth;
// 当天距离当月最后一天还有几天
+ (NSInteger)getNumbersOfDaysToLastDay;
// 当月的第几天
+ (NSDate*)getDateByDay:(NSInteger)day;
// 是否是相同年月
+ (BOOL)isSameYearMonth:(NSDate*)start endDate:(NSDate*)end;
// 比较两个时间相差（分钟/小时/天/月/年）
+ (NSString*)compareDiffer:(NSDate*)fromDate toDate:(NSDate*)toDate;
// 比较两个时间是否相差多少分钟分钟
+ (BOOL)compareDifferMinute:(NSDate*)fromDate toDate:(NSDate*)toDate minute:(NSInteger)minutes;
// 根据基础时间按月间隔计算新的时间(如:间隔1个月,2013-08-23 16:00:00 ---> 2013-09-23 16:00:00)
+ (NSDate*)dateByAddingIntervalMonth:(NSInteger)intervalMonth basicDate:(NSDate*)basicDate;
/* 两个时间比较(早,晚,相等)(mask YES代表年月日时分秒全量比较,NO代表只按年月日比较)
 *(fromDate > toDate:NSOrderedDescending)降序
 *(fromDate < toDate:NSOrderedAscending)升序
 *(fromDate = toDate:NSOrderedSame)相等*/
+ (NSComparisonResult)compareFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate isAll:(BOOL)mask;

+ (NSString *)intervalSinceNowWithFormatDate: (NSString *) theDate;
+ (NSString *)intervalSinceNowWithDate: (NSDate *) date;



//@caijie add
/**
 *  更新月
 */
+(NSDate *) dateByAddingMonths: (NSInteger) dMonths by:(NSDate*)aDate;
+(NSDate *) dateBySubtractingMonths: (NSInteger) dMonths by:(NSDate*)aDate;
//根据aDate 获取月份
+ (NSInteger) monthBy:(NSDate*)aDate;

+(NSDate*)dateByDateString:(NSString*)aDateString UseFormatString:(NSString*)formatString;
/**
 *  计算某一日期前后天数间隔的日期(柱状图需要)
 *
 */
+(NSDate *) dateWithDaysFromDate:(NSDate*)aDate ByAddingDays: (NSInteger) dDays;
+(NSDate *) dateWithDaysFromDate:(NSDate*)aDate BySubtractingDays: (NSInteger) dDays;

/**
 *  @author 蔡杰Alan, 15-04-17 10:04:31
 *
 *  @brief  日期  以后迁移到DateUntil
 */

+(NSDate *) dateAtStartOfDayByDate:(NSDate*)date;

+(NSDate *) dateAtEndOfDayByDate:(NSDate*)date;



/*
 *世界标准时间UTC /GMT 转为当前系统时区对应的时间
 */

+ (NSDate *) getNowDateFromatAnDate:(NSDate *)anyDate;

//判断是不是同一天
+ (BOOL)isSameDayWithTimestamp:(long long)date1 date2:(long long)date2;
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

+ (BOOL)isSameYearMonthWithTimestamp:(long long)start endDate:(long long)end;


@end
