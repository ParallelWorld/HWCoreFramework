//
//  NSDate+HWAdd.h
//  HWCoreFramework
//
//  Created by 58 on 6/23/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HWAdd)

#pragma mark - Component properties
@property (nonatomic, readonly) NSInteger hw_year; ///< Year component
@property (nonatomic, readonly) NSInteger hw_month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger hw_day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger hw_hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger hw_minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger hw_second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger hw_nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger hw_weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger hw_weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger hw_weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger hw_weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger hw_yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger hw_quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL hw_isLeapMonth; ///< Weather the month is leap month
@property (nonatomic, readonly) BOOL hw_isLeapYear; ///< Weather the year is leap year
@property (nonatomic, readonly) BOOL hw_isToday; ///< Weather date is today (based on current locale)
@property (nonatomic, readonly) BOOL hw_isYesterday; ///< Weather date is yesterday (based on current locale)

#pragma mark - Date modify
- (NSDate *)hw_dateByAddingYears:(NSInteger)years;
- (NSDate *)hw_dateByAddingMonths:(NSInteger)months;
- (NSDate *)hw_dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)hw_dateByAddingDays:(NSInteger)days;
- (NSDate *)hw_dateByAddingHours:(NSInteger)hours;
- (NSDate *)hw_dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)hw_dateByAddingSeconds:(NSInteger)seconds;

#pragma mark - Date format

/// Returns a formatted string representing this date.
///
/// see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns for format description.
///
/// e.g. @"yyyy-MM-dd HH:mm:ss"
- (NSString *)hw_stringWithFormat:(NSString *)format;

/// Returns a date parsed from given string interpreted using the format.
/// If can not parse the string, returns nil.
+ (NSDate *)hw_dateWithString:(NSString *)dateString format:(NSString *)format;

@end
