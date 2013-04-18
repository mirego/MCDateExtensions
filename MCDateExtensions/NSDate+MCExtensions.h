//
//  NSDate+MCExtensions.h
//  MCDateExtensions.iOS
//
//  Created by Simon Audet on 10-10-12.
//  Copyright (c) 2012 Mirego Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate (MCExtensions)

- (BOOL)isToday;
- (BOOL)isTodayUsingCalendar:(NSCalendar *)calendar;

- (BOOL)isYesterday;
- (BOOL)isYesterdayUsingCalendar:(NSCalendar *)calendar;

- (BOOL)isTomorrow;
- (BOOL)isTomorrowUsingCalendar:(NSCalendar *)calendar;

- (BOOL)isSameDayAsDate:(NSDate*)date;
- (BOOL)isSameDayAsDate:(NSDate*)date usingCalendar:(NSCalendar *)calendar;

//------------------------------------------------------------------------------

- (NSDateComponents *)components;
- (NSDateComponents *)componentsUsingCalendar:(NSCalendar *)calendar;

- (NSDateComponents *)componentsWithUnits:(NSUInteger)units;
- (NSDateComponents *)componentsWithUnits:(NSUInteger)units usingCalendar:(NSCalendar *)calendar;

//------------------------------------------------------------------------------

- (NSDate *)dateAtMidnight;
- (NSDate *)dateAtMidnightUsingCalendar:(NSCalendar *)calendar;

- (NSDate *)firstOfMonth;
- (NSDate *)firstOfMonthUsingCalendar:(NSCalendar *)calendar;

- (NSDate *)firstOfWeek;
- (NSDate *)firstOfWeekUsingCalendar:(NSCalendar *)calendar;

//------------------------------------------------------------------------------

- (NSDate *)dateByAddingYears:(NSInteger)years;
- (NSDate *)dateByAddingYears:(NSInteger)years usingCalendar:(NSCalendar *)calendar;

- (NSDate *)dateByAddingQuarters:(NSInteger)quarters;
- (NSDate *)dateByAddingQuarters:(NSInteger)quarters usingCalendar:(NSCalendar *)calendar;

- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)dateByAddingMonths:(NSInteger)months usingCalendar:(NSCalendar *)calendar;

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)dateByAddingWeeks:(NSInteger)weeks usingCalendar:(NSCalendar *)calendar;

- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateByAddingDays:(NSInteger)days usingCalendar:(NSCalendar *)calendar;

- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateByAddingHours:(NSInteger)hours usingCalendar:(NSCalendar *)calendar;

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes usingCalendar:(NSCalendar *)calendar;

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds;
- (NSDate *)dateByAddingSeconds:(NSInteger)seconds usingCalendar:(NSCalendar *)calendar;

- (NSDate *)dateByAddingCalendarUnit:(NSCalendarUnit)calendarUnit value:(NSInteger)value;
- (NSDate *)dateByAddingCalendarUnit:(NSCalendarUnit)calendarUnit value:(NSInteger)value usingCalendar:(NSCalendar *)calendar;

//------------------------------------------------------------------------------

+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;
+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar;

+ (NSInteger)weeksBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;
+ (NSInteger)weeksBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar;

+ (NSInteger)monthsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;
+ (NSInteger)monthsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar;

+ (NSInteger)yearsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;
+ (NSInteger)yearsBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime usingCalendar:(NSCalendar *)calendar;

@end
