// Copyright (c) 2013, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

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
